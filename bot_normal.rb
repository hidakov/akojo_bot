#!/usr/bin/ruby
#
require 'rubygems'
require 'twitter_oauth'

CONSUMER_KEY = 'xxxxxxxxxx'
CONSUMER_SECRET = 'xxxxxxxxxx'
ACCESS_TOKEN = 'xxxxxxxxxx'
ACCESS_SECRET = 'xxxxxxxxxx'

hashtag = "#ストブラ"
statements = [
"あの…姫柊、怒ってる？",
"やっぱ、もっときっちり向きあえってことか…。俺が第四真祖だってことに…。",
"眷獣か…ありゃ相当大物だな。",
"って、たまねぎ多すぎるだろ…。",
"オーダーメードドレス…B76-W55-H78、C60…。これって姫柊の？",
"勘弁してくれ…。",
"暑い…焼ける…焦げる…灰になる…。",
"あの制服…うちの中等部か。凪沙の友達？",
"姫柊はいい匂いがするなぁ。髪もサラサラして気持ちいいし。",
"几帳面な財布だな。それになんかいい香りも…。",
"姫柊って実は一人暮らしだったりする？",
"姫柊も普通にハンバーガー食べるんだな。",
"姫柊…もしかして風呂にでも入ってる途中で…慌てて出てきた？",
"姫柊って変なやつだな。",
"待てよ姫柊！まさか一人で行くつもりなのか！？",
"姫柊が心配なんだよ！",
"あのなぁ、姫柊…。",
"だって…姫柊はこんなに可愛いだろ。",
"姫柊…少しだけいいか？",
"まるでシンデレラみたいだなって思ってさ。姫柊も女の子だなぁ。",
"珍しいな。姫柊が髪飾りなんて。",
"どう見ても痛いコスプレ少女だよ、今の姫柊は。",
"べ、別に、姫柊に応援されるのが恥ずかしいとかそういんじゃないから。"
]

client = TwitterOAuth::Client.new(
	:consumer_key => CONSUMER_KEY,
	:consumer_secret => CONSUMER_SECRET,
	:token => ACCESS_TOKEN,
	:secret => ACCESS_SECRET
)

sleeptime = 60 * Random.rand(60)
sleep sleeptime

n = Random.rand(statements.length)
statement = statements[n] + " " + hashtag
client.update(statement)
