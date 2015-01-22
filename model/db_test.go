package model

import (
	// "github.com/jmoiron/sqlx"
	. "github.com/smartystreets/goconvey/convey"
	"golang.org/x/crypto/bcrypt"
	"os"
	"testing"
)

var sharedConnInfo = "./test.db"

func dropTestDb(t *testing.T) {
	os.Remove(sharedConnInfo)
}

func TestModel(t *testing.T) {
	Convey("Given there is no db yet", t, func() {
		dropTestDb(t)

		Convey("When a db is created", func() {
			appDb, err := CreateDb(sharedConnInfo)
			Reset(func() {
				appDb.Close()
			})

			Convey("There should be no errors", func() {
				So(err, ShouldBeNil)
			})

			Convey("And a user is created", func() {
				appDb.NewUser("johndoe", "secret")
				db := appDb.DbStore()

				Convey("User is saved stored on db", func() {
					user := User{}
					err := db.Get(&user, "SELECT * FROM user WHERE name=?", "johndoe")

					So(err, ShouldBeNil)
					So(user.Name, ShouldEqual, "johndoe")

					Convey("And should have hashed password", func() {
						So(bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte("secret")), ShouldBeNil)
					})
				})

				Convey("User can be authenticated", func() {
					user, err := appDb.Authenticate("johndoe", "secret")
					So(err, ShouldBeNil)
					So(user.Name, ShouldEqual, "johndoe")

					user, err = appDb.Authenticate("johndoe", "foo")
					So(err, ShouldResemble, UserAuthenticationError{"wrong password"})
					So(user, ShouldResemble, User{})
				})
			})

			Convey("And attempting to authenticate a non-existing user", func() {
				user, err := appDb.Authenticate("foo", "bar")

				Convey("Should not be authenticated", func() {
					So(err, ShouldResemble, UserAuthenticationError{"user not found"})
					So(user, ShouldResemble, User{})
				})
			})
		})

	})
}
