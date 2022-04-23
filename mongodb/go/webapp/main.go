package main

import "github.com/gin-gonic/gin"

func main() {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(200, "Hello, World!")
	})

	r.GET("/staj", func(c *gin.Context) {
		c.String(200, "Hello, this is staj path!")
	})

	r.Run(":3000")
}
