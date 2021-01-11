package redisfuncs

type Announcement struct {
	Title string 		`redis:"title" json:"title"`
	Description string  `redis:"author" json:"description"`
	Author string 		`redis:"author" json:"author"`
	Date string 		`redis:"date" json:"date"`
}

func CreateAnnouncement() Announcement {
	/*
	var date pgtype.Date
	var time time.Time = time.Now()

	err := date.AssignTo(time)
	if err != nil {
		fmt.Printf("Error occured with announcement date: %v", err)
	}
	 */

	var M Announcement

	M.Title = "Title test"
	M.Description = "Desc test"
	M.Author = "author test"
	M.Date = "date test"

	_ = Set(M)

	return M

}
