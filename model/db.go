package axya

import (
	"github.com/jmoiron/sqlx"
	_ "github.com/mattn/go-sqlite3"
	"golang.org/x/crypto/bcrypt"
)

type appDb struct {
	db *sqlx.DB
}

type AppDb interface {
	DbStore() *sqlx.DB
	Close() error
	NewUser(string, string)
	Authenticate(string, string)
}

func (db *appDb) Close() error {
	return db.db.Close()
}

func (db *appDb) DbStore() *sqlx.DB {
	return db.db
}

func (db *appDb) NewUser(name string, password string) {
	stmt, _ := db.db.Preparex(
		`INSERT INTO user(name, password_hash) ` +
			`VALUES (?, ?);`,
	)
	hash, _ := bcrypt.GenerateFromPassword([]byte(password), 5)
	stmt.Exec(name, string(hash))
}

func (db *appDb) Authenticate(name string, password string) (User, error) {
	user := User{}
	err := db.db.Get(&user, "SELECT * FROM user WHERE name=?", name)
	if err != nil {
		err = UserAuthenticationError{"user not found"}
		return user, err
	}
	if bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(password)) != nil {
		err = UserAuthenticationError{"wrong password"}
		user = User{}
	}
	return user, err
}

type User struct {
	Name         string
	PasswordHash string `db:"password_hash"`
}

func (db *appDb) createUserTable() (err error) {
	_, err = db.db.Exec(
		`CREATE TABLE user (` +
			`name            string NOT NULL, ` +
			`password_hash   string NOT NULL); ` +
			`CREATE INDEX user_idx ON user (name);`,
	)
	return err
}

type UserAuthenticationError struct {
	msg string
}

func (e UserAuthenticationError) Error() string {
	return e.msg
}

func CreateDb(conn string) (*appDb, error) {
	db, err := sqlx.Open("sqlite3", conn)
	a := new(appDb)
	a.db = db

	if err != nil {
		return a, err
	}

	err = a.createUserTable()

	return a, err
}
