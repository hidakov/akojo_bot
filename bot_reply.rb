#!/usr/bin/ruby
#
require 'rubygems'
require 'twitter_oauth'

CONSUMER_KEY = 'xxxxxxxxxx'
CONSUMER_SECRET = 'xxxxxxxxxx'
ACCESS_TOKEN = 'xxxxxxxxxx'
ACCESS_SECRET = 'xxxxxxxxxx'

statements = [
"すまん…。",
"別にいやらしいことじゃなくて…血を吸うには色々準備が…。",
"あれっ、そういう評価？俺、結構いいこと言ったよ。",
"ワターシ、トオリスガリノイターリアジンデース！",
"待て待て待て！今のは不可抗力だろ！"
]

filename = "/home/ec2-user/id_reply.txt"
count = 5
sleeptime = 60

client = TwitterOAuth::Client.new(
	:consumer_key => CONSUMER_KEY,
	:consumer_secret => CONSUMER_SECRET,
	:token => ACCESS_TOKEN,
	:secret => ACCESS_SECRET
)

file = File.open(filename)
since_id = file.gets
since_id = since_id.chomp
file.close

mentions = client.mentions(:since_id => since_id, :count => count)
id_updated = false
mentions.each do |mention|
	id = mention["id"]
	text = mention["text"]
	scr_name = mention["user"]["screen_name"]

	if (id_updated == false) then
		file = File.open(filename, "w")
		file.puts(id)
		file.close
		id_updated = true
	end

	if (text.match(/変態|いやらしい/) != nil) then
		n = Random.rand(statements.length)
		statement = "@" + scr_name + " " + statements[n] 
		client.update(statement, :in_reply_to_status_id => id)
		sleep sleeptime
	end
end

