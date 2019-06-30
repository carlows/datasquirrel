# Datasquirrel

![squirrel](http://icons.iconarchive.com/icons/majdi-khawaja/ice-age-4/256/Scrat-icon.png)

A REST API to track your team's devops metrics.

## Inspiration

Datasquirrel is a simple data endpoint to store all your metrics. You can deploy this endpoint to AWS Lambda and make use of that wonderful free tier :)

## Usage

Datasquirrel has been built on top of https://rubyonjets.com/

Run it locally using `jets server`.

### Create a new group

POST: http://localhost:8888/groups

```
curl -X POST \
  http://localhost:8888/groups \
  -d '{
	"name": "test"
}'
```

This resource allows you to group multiple metrics under the same name.

### Emit new count points

A count metric has no value, you call a single endpoint to increment a count

```
curl -X POST \
  http://localhost:8888/groups/<group-name>/count/emit \
  -d '{
	"slug": "lead-time"
}'
```

### Emit new gauge points

A gauge metric allows you to track the value of something (like a ticket's lead time).

```
curl -X POST \
  http://localhost:8888/groups/test/gauge/emit \
  -d '{
	"slug": "test",
	"value": 1.5
}'
```

The value has no unit, so you can count your metric as days, hours or whatever you want.

### Query metrics

#### Get a count metric for all time

```
curl -X GET 'http://localhost:8888/groups/test/count?slug=lead-time'
```

#### Get a count metric for the last month

```
curl -X GET 'http://localhost:8888/groups/gsw/count?slug=lead-time&current_month=true'
```

#### Get a count metric for the last year

```
curl -X GET 'http://localhost:8888/groups/gsw/count?slug=lead-time&current_year=true'
```

#### Get the latest value of a gauge metric

```
curl -X GET 'http://localhost:8888/groups/gsw/gauge/latest?slug=lead-time'
```

#### Get the average value of a gauge metric for all time

```
curl -X GET 'http://localhost:8888/groups/gsw/gauge/mean?slug=lead-time'
```

#### Get the average value of a gauge metric for the current month

```
curl -X GET 'http://localhost:8888/groups/gsw/gauge/mean?slug=lead-time&current_month=true'
```
