# Roadpass API

A Ruby on Rails API that serves trip/destination data, supporting listing, filtering, sorting, and detailed trip retrieval. This project demonstrates clean RESTful API design, database management, error handling, and integration with [a front-end app](https://github.com/tedyAA/roadpass_api_frontend).

## Overview
This API exposes trip data, including:

* Trip name, images, short and long descriptions, and rating (1–5)

* Search by name (case-insensitive)

* Filter by minimum rating

* Sort by rating ascending/descending or by name

* Pagination with metadata

The API is built to work seamlessly with a frontend client but can also serve as a standalone service.

## Tech Stack

* Ruby on Rails 7

* PostgreSQL

* RSpec for testing

* Kaminari for pagination

## Setup & Installation

1. Clone the repository:
```bash
git clone https://github.com/tedyAA/roadpass_api.git
cd roadpass_api
```

2. Install dependencies:

```bash
bundle install
```
3. Setup the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the Rails server:
```bash
rails s
```
The API will run at http://localhost:3000.

##API Endpoints

| Method  | Path | Description |
| ------------- | ------------- |------------- |
| GET  | /api/v1/trips  | List trips (supports search, filter, sort, pagination)  |
| GET  | /api/v1/trips/:id  |  Retrieve a single trip  |
| POST  | /api/v1/trips  | Create a new trip  |

## Query Parameters for Listing

* search: Filter trips by name (partial match)

* min_rating: Filter trips by minimum rating

* sort: asc or desc (by rating). Default alphabetical by name

* page / per_page: Pagination (default 10 per page)

## Features

* Clean RESTful API design with proper HTTP status codes

* Full CRUD support for trips

* Pagination metadata in all list responses

* Search, filter, and sorting implemented efficiently

* Strong parameter protection and input validation

* Frontend-friendly JSON responses with a serializer

## Error Handling

* Returns 404 for missing trips

* Returns 422 for invalid trip creation requests

* Graceful fallback with seeded backup data if API errors occur

* Frontend shows loading state, error state, and empty search state

## Testing

Tests are written using RSpec:

* Model specs for validations

* Request specs for API endpoints covering:

   Listing, searching, filtering, sorting, pagination

    Trip creation (valid & invalid inputs)

    Show endpoint and error handling

Run tests with:

```bash
bundle exec rspec
```
