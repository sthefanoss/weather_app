# Weather App

An app to show weather information.

## 1. How to Use
### 1.1 API Requirement
Since this app uses [OpenWeatherApi](https://openweathermap.org/), an `API_KEY` is required. 

Create your account and set the `API_KEY` in the `.env` file as follows:

> OPEN_WEATHER_API_KEY='XXXXXXXXXXXXXX'

### 1.2 SDK Requirement
This project was made with Flutter version 3.22.1 for Android and iOS. For installation guidance, check out [Flutter Tutorial](https://docs.flutter.dev/get-started/install).

## 2. App Features
There are three pages for the user to interact with. The first page lists the places where there will be concerts. When the user selects a place, they are redirected to a page that shows the current weather data for that place. The user can tap another button (inside this page) to read the forecast for the next 5 days for the same place or go back.

### 2.1 Concert List Page
This page lists the places where you, as a band member, are interested in knowing the forecast. You can filter the places by name if you want to.

### 2.2 Current Weather Page
This page shows the current temperature, humidity, wind speed, rain, and snow for a specific place. There is a beautiful icon on it as well, thanks to the `OpenWeatherApi` designers!

### 2.3 Forecast Page
This page shows the temperature, humidity, wind speed, rain, and snow for the next 5 days, with updates every 3 hours. Each entry includes a timestamp and an icon.

## 3. Offline/Cache Behaviour
The most interesting part of this application is how it handles the cache. The following rules apply to both the Current Weather and Forecast pages (not necessary for the Concert List Page since it's offline):

1. Before every API call, check if there is any cached request.
2. If there is a cached value that is not expired, use it and show the user the last time the cache was updated. END.
3. If there is a cached value that has expired, call the API.
4. If there is no cached value, call the API.
5. Save the API response in the cache if successful. END.
6. If the API fails due to a connection fault and there is a cached value, use it (even if expired), but show the user that they are offline and the last time the cache was updated.
7. If the API fails due to a connection fault and there is no cached value, show a "No connection" error with a retry button. END.
8. If the API fails for any other reason, show a generic error with a retry button. END.

## 4. Tests
Tests were made using `mocktail`. There is a UI test for the Concert List Page, but most of the test effort was focused on page controllers.

## 5. THE END
Thanks for reading this.