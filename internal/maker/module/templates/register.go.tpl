package {{ .Name }}

import (
	"github.com/labstack/echo/v5"
	"go.uber.org/fx"

	"{{ .ModuleImportPath }}/internal/modules/{{ .Name }}/api"
)

type httpParams struct {
	fx.In

	Echo       *echo.Echo
	Controller *Controller
}

func RegisterHTTP(p httpParams) {
	api.RegisterRoutes(p.Echo, p.Controller, nil)
}