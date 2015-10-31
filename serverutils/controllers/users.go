package controllers

import (
	"github.com/asartalo/axya/model"
	"github.com/asartalo/axya/serverutils"
	"github.com/gin-gonic/gin"
	"net/http"
)

type UsersControllers struct {
	AppDb model.AppDb
}

func (ctrl UsersControllers) PostUsers(c *gin.Context) {
	responder := serverutils.NewResponder(c)
	var creds serverutils.Credentials
	err := c.BindJSON(&creds)
	if err != nil {
		responder.Error(
			http.StatusBadRequest,
			"Make sure credentials are complete.",
			err.Error(),
		)
		return
	}
	user, err := ctrl.AppDb.NewUser(creds.Name, creds.Password)
	if err != nil {
		responder.Error(
			http.StatusInternalServerError,
			"Error: "+err.Error(),
			err.Error(),
		)
		return
	}
	responder.Created("User created", gin.H{"name": user.Name})
}
