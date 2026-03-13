package http

import (
	echo "github.com/labstack/echo/v5"
	"go.uber.org/zap"
)

func NewEcho(logger *zap.Logger) *echo.Echo {
	e := echo.New()
	return e
}
