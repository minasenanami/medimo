# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
require File.expand_path(File.dirname(__FILE__) + "/environment")

set :output, "log/cron_log.log"

# 実行環境の指定
set :environment, :production

# every 3.minute do
#   rake "clean_active_storage_blobs:metadata"
#   rake "clean_tags:tag_name"
# end
every 1.week do
  rake "clean_active_storage_blobs:metadata"
  rake "clean_tags:tag_name"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
