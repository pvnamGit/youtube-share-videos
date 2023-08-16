# Youtube Share Videos

This README would normally document whatever steps are necessary to get the
application up and running.

## I. Introduction
"Youtube Share Videos" is a web application designed to simplify the process of sharing and discovering YouTube videos. Users can easily create an account, share their favorite videos by providing a YouTube link, and explore a list of videos shared by others.

### 1. Key features
1. **User Registration and Login:** 
2. **Sharing YouTube Videos:**
3. **Viewing Shared Videos:**
4. **Real-time Notifications:** When a user shares a new video, other logged-in users are instantly notified about the latest addition to the video list.
## II. Things you may want to cover:

* **Ruby version**

  `ruby 2.7.4p191 (2021-07-07 revision a21a3b7d23) [x86_64-linux]`
* **Rails version**

  `Rails 6.0.6.1`

* **Database**

  `PostgreSQL 11`
* **Youtube API**

- Read the docs to create Youtube API Key and enabled YouTube Data API v3:
    > https://developers.google.com/youtube/v3/getting-started
  
## III. Installation
### 1. Clone project

  To get started with the project, you can clone the repository using the command:
  > https://github.com/pvnamGit/youtube-share-videos.git

  Run this command
  > yarn install
  >
  > bundle install

### 2. Environment Configuration

Create `.env` file to the root directory, add the key to file:
`YOUTUBE_API_KEY=<your_api_key>`

### 3. Database creation

- Create new database for development (For example: video_shares)
  > CREATE DATABASE video_shares;


- Create new database for test (For example: video_shares_test)
  > CREATE DATABASE video_shares_test;

**Open file `config/database.yml`, modified `database, username, password` of each group.**

### 4. Database initialization

  Run command

  > rails db:migrate

### 5. How to run the test suites
- Before running test, run command to init test database
  > rake db:test:prepare
- For unit test, run command
  > bundle exec rspec ./spec/requests/<file_name.rb>
- For integration test, run command
  > bundle exec rspec ./spec/features/<file_name.rb>
- For test all the project
  > rspec

### 6. Start server
Run two commands on 2 terminal tabs respective
- **Rails server:**
> rails server
- **Redis server:**
> redis-server

### 7. Running the application
Open browser, type `http://localhost:3000` and then explore the application.

## IV. Usage on development environment
1. **User Registration and Login:**
Go to `http://localhost:3000/`, click to the "Sign up" at the top right of application to register a new account.
If you have already created yet, click to the "Login" button. Or else, you can go direct link `http://localhost:3000/sessions` to login or `http://localhost:3000/users` to register an account.

2. **Sharing YouTube Videos:**
Once you logged in, you can share a youtube video by click to the `Share video` button at the top right of the application, or go direct to `http://localhost:3000/video_shares/new` 
If you want to see your shared videos, you should click to 'My shared video' button or go to link `http://localhost:3000/my_videos`

3. **Delete Shared Video:**
   You should click to 'My shared video' button or go to link `http://localhost:3000/my_videos`, then click `Delete this video` button, the alert will show to get your delete confirmation. Press "OK" to delete the video.

## V. Troubleshooting
1. Can't get metadata from Youtube's link.
    Please ensure that your API key is correct, as well as you have already enabled the YouTube Data API v3. If the error still occur, try this command: 
    > export YOUTUBE_API_KEY=<your_api_key>
2. 404 when getting packs
    You should remove the packs package in `public` folder by this command
    > rails webpacker:clobber
   
    And then recomplie webpack and restart the server.
    > rails webpacker:compile 
 
