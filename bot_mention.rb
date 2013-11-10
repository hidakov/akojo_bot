#!/usr/bin/ruby
#
require 'rubygems'
require 'twitter_oauth'

CONSUMER_KEY = 'xxxxxxxxxx'
CONSUMER_SECRET = 'xxxxxxxxxx'
ACCESS_TOKEN = 'xxxxxxxxxx'
ACCESS_SECRET = 'xxxxxxxxxx'

name_trans = {
	"姫柊" => "姫柊",
	"雪菜" => "姫柊",
	"藍羽" => "浅葱",
	"浅葱" => "浅葱",
	"南宮" => "那月ちゃん",
	"那月" => "那月ちゃん",
	"煌坂" => "煌坂",
	"紗矢華" => "煌坂",
	"凪沙" => "凪沙"
}
smells_good = "はいい匂いがするなぁ。"
prpr = "ぺろぺろ"
self_scr_name = "akojo_bot"
keyword = "#ストブラ"
filename = "~/id_mention.txt"
count = 50

client = TwitterOAuth::Client.new(
	:consumer_key => CONSUMER_KEY,
	:consumer_secret => CONSUMER_SECRET,
	:token => ACCESS_TOKEN,
	:secret => ACCESS_SECRET
)

file = File.open(filename)
str = file.gets
tmp = str.chomp.split("\t")
since_id = tmp[0]
prev_name = tmp[1]
file.close

search = client.search(keyword, :since_id => since_id, :count => count)
statuses = search["statuses"].reverse

pattern = name_trans.keys.join("|")
statuses.each do |status|
	id = status["id"]
	text = status["text"]
	scr_name = status["user"]["screen_name"]

	if (status["retweeted_status"] != nil || scr_name == self_scr_name || scr_name == prev_name) then
		next
	end

	if (text.match(/#{pattern}/) != nil) then
		match = Regexp.last_match()
		name = name_trans["#{match}"]

		if (Random.rand(2) == 0) then
			statement = "@" + scr_name + " " + name + smells_good
		else 
			statement = "@" + scr_name + " " + name + prpr

		end

		client.update(statement, :in_reply_to_status_id => id)
		
		file = File.open(filename, "w")
		file.puts("#{id}\t#{scr_name}")
		file.close
		break
	end
end

