# Simple Weather
A simple temperature data fetcher on ruby.

![status](https://github.com/tee0zed/simple_weather/actions/workflows/ruby.yml/badge.svg)

## Providers

- [:open_weather](https://openweathermap.org/)
- [:weather_api](https://www.weatherapi.com/)

##
Part of Thinknetica codecamp task that got out of control lmao


## Usage

```ruby
gem install simple_weather
```

```ruby

require 'simple_weather'

 SimpleWeather.fetch(
   provider: :open_weather, 
   units: :metric, 
   request_name: :current_weather, 
   params: {lat: 1.33, lon: 1.33}
 ).temperature
```


```ruby
args = {
  provider: [:open_weather, :weather_api], 
  units: [:metric, :imperial],
  request_name: [:current_weather, :history_weather],
  params: [
    {lat: 1.3 3, lon: 1.33}, # for current_weather
    {lat: 1.3 3, lon: 1.33, date: Date.today.iso8601}  # for history_weather
  ]
}
```
