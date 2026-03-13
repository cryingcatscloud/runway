package http

import (
	"context"
	"net/http"
	"time"

	"github.com/labstack/echo/v5"
	"go.uber.org/fx"

	"{{ .ModulePath }}/app/config"
)

func RegisterLifecycle(
	lc fx.Lifecycle,
	e *echo.Echo,
	cfg *config.HTTPConfig,
) {
	server := &http.Server{
		Addr:         cfg.PublicAddr,
		Handler:      e,
		ReadTimeout:  time.Duration(cfg.ReadTimeout) * time.Second,
		WriteTimeout: time.Duration(cfg.WriteTimeout) * time.Second,
		IdleTimeout:  time.Duration(cfg.IdleTimeout) * time.Second,
	}

	lc.Append(fx.Hook{
		OnStart: func(ctx context.Context) error {
			go func() {
				if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
					e.Logger.Fatal(err)
				}
			}()
			return nil
		},
		OnStop: func(ctx context.Context) error {
			return server.Shutdown(ctx)
		},
	})
}
