package {{ .Name }}

import (
	"github.com/labstack/echo/v5"
)

type Controller struct {
	service *Service
}

func NewController(e *echo.Echo, service *Service) *Controller {
	controller := &Controller{service: service}
	return controller
}
