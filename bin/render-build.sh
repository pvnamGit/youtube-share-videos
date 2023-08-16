databases:
  - name: youtube_share_videos
    databaseName: youtube_share_videos
    user: youtube_share_videos_user

services:
  - type: web
    name: youtube_share_videos
    env: ruby
    buildCommand: "./bin/render-build.sh"
    startCommand: "bundle exec puma -C config/puma.rb"
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: mysite
          property: connectionString
      - key: RAILS_MASTER_KEY
        sync: false

