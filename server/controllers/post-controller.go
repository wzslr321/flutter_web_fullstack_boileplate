package controllers

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/graphql-go/graphql"
	"github.com/lib/pq"
	"log"
	"github.com/wzslr321/models"
)

type Result struct {
	Message string
}

var Posts = []models.Post{
	{
		ID:    1,
		Title:  "Chicha Morada",
		Description:  "Chicha morada is a beverage originated in the Andean regions of Perú but is actually consumed at a national level (wiki)",
	},
	{
		ID:    2,
		Title:  "Chicha de jora",
		Description:  "Chicha de jora is a corn beer chicha prepared by germinating maize, extracting the malt sugars, boiling the wort, and fermenting it in large vessels (traditionally huge earthenware vats) for several days (wiki)",
	},
	{
		ID:    3,
		Title:  "Pisco",
		Description:  "Pisco is a colorless or yellowish-to-amber colored brandy produced in winemaking regions of Peru and Chile (wiki)",
	},
}

func populate() []models.Post {
	postsValues := []int64{1,2}
	comments := []models.Comment{
		{Body: "Very cool post"},
	}

	author := &models.Author{Name: "Viktor", Posts:pq.Int64Array(postsValues)}
	post := models.Post{
		ID:1,
		Title: "My very first post",
		Author: *author,
		Comments:comments,
	}
	post2 := models.Post{
		ID:2,
		Title:"My second post",
		Author: *author,
		Comments: []models.Comment{
			{Body: "Keep it up"},
		},
	}

	var posts []models.Post
	posts = append(posts,post)
	posts = append(posts,post2)

	return posts
}

var authorType = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "Author",
		Fields: graphql.Fields{
			"Name":&graphql.Field{
				Type: graphql.String,
			},
			"Posts": &graphql.Field{
				Type: graphql.NewList(graphql.Int),
			},
		},
	},
)

var commentType = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "Comment",
		Fields: graphql.Fields{
			"body": &graphql.Field{
				Type:graphql.String,
			},
		},
	},
)

var postType = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "Post",
		Fields: graphql.Fields{
			"id":&graphql.Field{
				Type: graphql.Int,
			},
			"title":&graphql.Field{
				Type: graphql.String,
			},
			"description": &graphql.Field{
				Type: graphql.String,
			},
			"author":&graphql.Field{
				Type: authorType,
			},
			"comments":&graphql.Field{
				Type: commentType,
			},
		},
	},
)

var queryType = graphql.NewObject(
	graphql.ObjectConfig{
		Name:"Query",
		Fields: graphql.Fields{
			"post":&graphql.Field{
				Type:        postType,
				Description: "Get post by id",
				Args: graphql.FieldConfigArgument{
					"id":&graphql.ArgumentConfig{
						Type: graphql.Int,
					},
				},
				Resolve: func(p graphql.ResolveParams) (interface{}, error) {
					id,ok := p.Args["id"].(int)
					if ok {
						for _, post := range Posts {
							if (post.ID) == id {
								return post,nil
							}
						}
					}
					return nil,nil
				},
			},
		"list":&graphql.Field{
				Type:graphql.NewList(postType),
				Description: "Get all posts",
				Resolve: func(p graphql.ResolveParams) (interface{}, error) {
					return Posts,nil
				},
		},
		},
	},
)

var mutationType = graphql.NewObject(graphql.ObjectConfig{
	Name: "Mutation",
	Fields: graphql.Fields{
		"create":&graphql.Field{
			Type:        postType,
			Description: "Create a new post",
			Args: graphql.FieldConfigArgument{
				"title" : &graphql.ArgumentConfig{
					Type: graphql.NewNonNull(graphql.String),
				},
				"description":&graphql.ArgumentConfig{
					Type: graphql.String,
				},
			},
			Resolve: func(p graphql.ResolveParams) (interface{}, error) {
				post := models.Post{
					Title: p.Args["title"].(string),
					Description: p.Args["description"].(string),
				}
				Posts = append(Posts, post)
				return post,nil
			},
		},
	},
})

var schema, _ = graphql.NewSchema(
	graphql.SchemaConfig{
		Query:    queryType,
		Mutation: mutationType,
	})

func executeQuery(query string, schema graphql.Schema) *graphql.Result  {
	result := graphql.Do(graphql.Params{
		Schema: schema,
		RequestString: query,
	})
	if len(result.Errors) > 0 {
		log.Printf("Error occured while executing post query: %v", result.Errors)
	}
	return result
}

func MainPostController(ctx *gin.Context) {

	populate()

	result := executeQuery(ctx.Query("query"), schema)
	_ = json.NewEncoder(ctx.Writer).Encode(result)

}

