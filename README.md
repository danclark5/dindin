# Din Din

This is a application based on [Michael Hartl's Rails Tutorial](https://www.railstutorial.org/). It's designed to store
and serve dinner ideas, pun intended.

## Requirements
- Ruby 2.?
- Rails 5.1?

## Getting Started

First clone the repo and install the needed gems.

```
bundle install --without production
```

Other things I may cover

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Planning

### Requirements
- Basic meal suggestions for x days for y people to create a meal schedule.
- It's acceptable to make it so that meals are randomly selected at first. Eventually this should have some logic to
  avoid repeats or suggest favorites periodically.
- Should be able ask for a new suggestion for initial, undesirable meal suggestions (Roll again).
- Should be able to raise a dialog to replace meal suggestions with specific meals. (I know what I want)
- Should be able to remove a meal (because we're skipping that meal for some reason)
- At first don't worry about users, but if we want to make this usable to others we'll need to add in users.
- Needs to be able to display meals.
  - View schedule (high level)
  - Today's meals
  - Next meal.
- Create shopping list based off of meal listing.

### Persistence Schema
- scheduled_meals: Links meals that have been scheduled.
  - participant_count_override
- meals: General description of potential meals
- ingredients: for each meal by person
