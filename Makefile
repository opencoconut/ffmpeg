TEMPLATE_NAME ?= fccn/ffmpeg

run: image
	docker run -v=`pwd`:/tmp/ffmpeg $(TEMPLATE_NAME)

shell: image
	docker run -a stdin -a stdout -i -t --entrypoint=/bin/sh $(TEMPLATE_NAME)

image:
	docker build -t $(TEMPLATE_NAME) .

stop:
	docker ps | grep $(TEMPLATE_NAME) | cut -f1 -d' ' | xargs docker stop