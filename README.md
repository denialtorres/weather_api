# README

## API ENDPOINT CALL

```ruby
curl -X GET "http://localhost:3000/api/v1/weather?query=mon" -H "Content-Type: application/json"
```

response

```json
{
  "success": true,
  "data": [
    {
      "city": "Monterrey",
      "weather": [
        {
          "date": "2025-04-03T12:00:00Z",
          "temperature_avg": 28.4,
          "temperature_max": 33.9,
          "temperature_min": 22.1
        },
        {
          "date": "2025-04-04T12:00:00Z",
          "temperature_avg": 27.1,
          "temperature_max": 32.4,
          "temperature_min": 19.5
        },
        {
          "date": "2025-04-05T12:00:00Z",
          "temperature_avg": 23.2,
          "temperature_max": 30.4,
          "temperature_min": 15.2
        },
        {
          "date": "2025-04-06T12:00:00Z",
          "temperature_avg": 16.5,
          "temperature_max": 20.7,
          "temperature_min": 13.2
        },
        {
          "date": "2025-04-07T12:00:00Z",
          "temperature_avg": 17.9,
          "temperature_max": 24.4,
          "temperature_min": 9.1
        },
        {
          "date": "2025-04-08T12:00:00Z",
          "temperature_avg": 19.1,
          "temperature_max": 25.7,
          "temperature_min": 9.1
        }
      ]
    }
  ]
}
```

## Docker

To mount the project

inside the main foler:

```
docker-compose up --build
```

To connect to the rails console

```
docker-compose exec app rails c
```

Run the server

```
docker-compose exec app rails server -b 0.0.0.0
```
