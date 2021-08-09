FROM alpine as build
WORKDIR /app
COPY src src
RUN [ "make", "build" ]

FROM alpine
WORKDIR /app
COPY --from=build /app/build /app

EXPOSE 8080
ENTRYPOINT [ "make", "run" ]
