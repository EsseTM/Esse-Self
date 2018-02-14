tdbot = dofile("./bot/function.lua")
-------------------------------
SUDO_ID = {433696226}
my = '433696226'
badkhah = {
"sajad momen",
}
myname = { 
"@essetm",
  }
Answer = {
"join sho",
}
YML = {
"ngaiidam",
}
--------------------------------
color = {
black = {30, 40},
red = {31, 41},
green = {32, 42},
yellow = {33, 43},
blue = {34, 44},
magenta = {35, 45},
cyan = {36, 46},
white = {37, 47}
}
Redis =  require ('redis')
redis = Redis.connect('127.0.0.1', 6379)
------------Chat Type------------
flood_MAX = 3
if redis:get(my..'Flood:Max:'..my) then
flood_MAX = redis:get(my..'Flood:Max:'..my)
end
TIME_CHECK = 2
if redis:get(my..'Flood:Time:'..my) then
TIME_CHECK = redis:get(my..'Flood:Time:'..my)
end
function chat_type(chat_id)
local chat_type = "private"
local id = tostring(chat_id)
if id:match("^-100") then
chat_type = "supergroup"
elseif id:match("^-") then
chat_type = "group"
end
return chat_type
end
function serialize_to_file(data, file, uglify)
file = io.open(file, 'w+')
local serialized
if not uglify then
serialized = serpent.block(data, {
comment = false,
name = '_'
})
else
serialized = serpent.dump(data)
end
file:write(serialized)
file:close()
end
function run_command(str)
local cmd = io.popen(str)
local result = cmd:read('*all')
cmd:close()
return result
end
function string.random(length)
   local str = "";
   for i = 1, length do
      math.random(97, 122)
      str = str..string.char(math.random(97, 122));
   end
   return str;
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

-- DEPRECATED
function string.trim(s)
  print("string.trim(s) is DEPRECATED use string:trim() instead")
  return s:gsub("^%s*(.-)%s*$", "%1")
end

-- Removes spaces
function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end
function get_9GAG()
local url = 'http://api-9gag.herokuapp.com/'
local b,c = http.request(url)
if c ~= 200 then
return nil
end
function string.starts(String, Start)
  -- print("string.starts(String, Start) is DEPRECATED use string:starts(text) instead")
  -- uncomment if needed
  return Start == string.sub(String,1,string.len(Start))
end

-- Returns true if String starts with Start
function string:starts(text)
  return text == string.sub(self,1,string.len(text))
end

local gag = json:decode(b)
local i = math.random(#gag)
local link_image = gag[i].src
local title = gag[i].title
if link_image:sub(0,2) == '//' then
link_image = msg.text:sub(3,-1)
end
return link_image, title
end

function get_http_file_name(url, headers)
local file_name = url:match("[^%w]+([%.%w]+)$")
file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
file_name = file_name or str:random(5)
local content_type = headers["content-type"]
local extension = nil
if content_type then
extension = mimetype.get_mime_extension(content_type)
end
if extension then
file_name = file_name.."."..extension
end
local disposition = headers["content-disposition"]
if disposition then
file_name = disposition:match('filename=([^;]+)') or file_name
end
return file_name
end
function DownloadFile(url, file_name)
 print("url to download: "..url)
local respbody = {}
local options = {
url = url,
sink = ltn12.sink.table(respbody),
redirect = true
}
local response = nil
if url:match('^https') then
options.redirect = false
response = {https.request(options)}
else
response = {http.request(options)}
end
local code = response[2]
local headers = response[3]
local status = response[4]
if code ~= 200 then return nil end
file_name = file_name or get_http_file_name(url, headers)
local file_path = "./"..file_name
 print("Saved to: "..file_path)
file = io.open(file_path, "w+")
file:write(table.concat(respbody))
file:close()
return file_path
end
function download(url, file_name)
print("url to download: "..url)
local respbody = {}
local options = {
url = url,
sink = ltn12.sink.table(respbody),
redirect = true
}
local response = nil
if url:match('^https') then
options.redirect = false
response = {https.request(options)}
else
response = {http.request(options)}
end
local code = response[2]
local headers = response[3]
local status = response[4]
if code ~= 200 then return nil end
file_name = file_name or get_http_file_name(url, headers)
local file_path = "./DWN"..file_name
print("Saved to: "..file_path)
file = io.open(file_path, "w+")
file:write(table.concat(respbody))
file:close()
return file_path
end
function getRandomButts(attempt)
attempt = attempt or 0
attempt = attempt + 1
local res,status = http.request("http://api.obutts.ru/noise/1")
if status ~= 200 then return nil end
local data = json:decode(res)[1]
if not data and attempt <= 3 then
print('Cannot get that butts, trying another one...')
return getRandomButts(attempt)
end
return 'http://media.obutts.ru/' .. data.preview
end
function getRandomBoobs(attempt)
attempt = attempt or 0
attempt = attempt + 1
local res,status = http.request("http://api.oboobs.ru/noise/1")
if status ~= 200 then return nil end
local data = json:decode(res)[1]
if not data and attempt < 10 then 
print('Cannot get that boobs, trying another one...')
return getRandomBoobs(attempt)
end
return 'http://media.oboobs.ru/' .. data.preview
end

function Calculate(msg, exp)
local res = http.request('http://api.mathjs.org/v1/?expr=' .. URL.escape(exp))
if not res then
res = 'Error 404!'
end
tdbot.send(msg.chat_id,msg.id,res,'md')
end
function scandir(directory)
local i, t, popen = 0, {}, io.popen
for filename in popen('ls -a "'..directory..'"'):lines() do
i = i + 1
t[i] = filename
end
return t
end
local usr = io.popen("whoami"):read("*a")
usr = string.gsub(usr, "^%s+", "")
usr = string.gsub(usr, "%s+$", "")
usr = string.gsub(usr, "[\n\r]+", " ")
redis:set(my.."UserID", usr)
function is_supergroup(msg)
chat_id = tostring(msg.chat_id)
if chat_id:match('^-100') then 
if not msg.is_post then
return true
end
else
return false
end
end
function is_channel(msg)
chat_id = tostring(msg.chat_id)
if chat_id:match('^-100') then 
if msg.is_post then -- message is a channel post
return true
else
return false
end
end
end
function is_group(msg)
chat_id= tostring(msg.chat_id)
if chat_id:match('^-100') then 
return false
elseif chat_id:match('^-') then
return true
else
return false
end
end
function is_private(msg)
chat_id = tostring(msg.chat_id)
if chat_id:match('^-') then
return false
else
return true
end
end
function check_markdown(text) 
str = text
if str then
if str:match('_') then
output = str:gsub('_',[[\_]])
elseif str:match('*') then
output = str:gsub('*','\\*')
elseif str:match('`') then
output = str:gsub('`','\\`')
else
output = str
end
return output
end
end
function ec_name(names) 
name = names
if name then
if name:match('_') then
name = name:gsub('_','')
end
if name:match('*') then
name = name:gsub('*','')
end
if name:match(']') then
name = name:gsub(']','')
end
if name:match('[[(]]') then
name = name:gsub('(','')
end
if name:match('[[)]]') then
name = name:gsub(')','')
end
if name:match(']') then
name = name:gsub(']','')
end
if name:match('`') then
name = name:gsub('`','')
end
 return name
end
end;autoupdate=363936960;local function run_bash(str)
local cmd = io.popen(str)
local result = cmd:read('*all')
return result
end
local color = {
  black = {30, 40},
  red = {31, 41},
  green = {32, 42},
  yellow = {33, 43},
  blue = {34, 44},
  magenta = {35, 45},
  cyan = {36, 46},
  white = {37, 47}
}
function is_sudo(msg)
local var = false
for v,user in pairs(SUDO_ID) do
if user == msg.sender_user_id then
var = true
end
end
return var
end
function is_Enemy(msg)
local hash =  redis:sismember(my..'EnemyList:',msg.sender_user_id)
if hash then
return true
else
return false
end
end
fohsh = {
"گص کش",
"کس ننه",
"کص ننت",
"کس خواهر",
"کس خوار",
"کس خارت",
"کس ابجیت",
"کص لیس",
"ساک بزن",
"ساک مجلسی",
"ننه الکسیس",
"نن الکسیس",
"ناموستو گاییدم",
"ننه زنا",
"کس خل",
"کس مخ",
"کس مغز",
"کس مغذ",
"خوارکس",
"خوار کس",
"خواهرکس",
"خواهر کس",
"حروم زاده",
"حرومزاده",
"خار کس",
"تخم سگ",
"پدر سگ",
"پدرسگ",
"پدر صگ",
"پدرصگ",
"ننه سگ",
"نن سگ",
"نن صگ",
"ننه صگ",
"ننه خراب",
"تخخخخخخخخخ",
"نن خراب",
"مادر سگ",
"مادر خراب",
"مادرتو گاییدم",
"تخم جن",
"تخم سگ",
"مادرتو گاییدم",
"ننه حمومی",
"نن حمومی",
"نن گشاد",
"ننه گشاد",
"نن خایه خور",
"تخخخخخخخخخ",
"نن ممه",
"کس عمت",
"کس کش",
"کس بیبیت",
"کص عمت",
"کص خالت",
"کس بابا",
"کس خر",
"کس کون",
"کس مامیت",
"کس مادرن",
"مادر کسده",
"خوار کسده",
"تخخخخخخخخخ",
"ننه کس",
"بیناموس",
"بی ناموس",
"شل ناموس",
"سگ ناموس",
"ننه جندتو گاییدم باو ",
"چچچچ نگاییدم سیک کن پلیز D:",
"ننه حمومی",
"چچچچچچچ",
"لز ننع",
"ننه الکسیس",
"کص ننت",
"بالا باش",
"ننت رو میگام",
"کیرم از پهنا تو کص ننت",
"مادر کیر دزد",
"ننع حرومی",
"تونل تو کص ننت",
"کیر تک تک بکس تلع گلد تو کص ننت",
"کص خوار بدخواه",
"خوار کصده",
"ننع باطل",
"حروم لقمع",
"ننه سگ ناموس",
"منو ننت شما همه چچچچ",
"ننه کیر قاپ زن",
"ننع اوبی",
"ننه کیر دزد",
"ننه کیونی",
"ننه کصپاره",
"زنا زادع",
"کیر سگ تو کص نتت پخخخ",
"ولد زنا",
"ننه خیابونی",
"هیس بع کس حساسیت دارم",
"کص نگو ننه سگ که میکنمتتاااا",
"کص نن جندت",
"ننه سگ",
"ننه کونی",
"ننه زیرابی",
"بکن ننتم",
"ننع فاسد",
"ننه ساکر",
"کس ننع بدخواه",
"نگاییدم",
"مادر سگ",
"ننع شرطی",
"گی ننع",
"بابات شاشیدتت چچچچچچ",
"ننه ماهر",
"حرومزاده",
"ننه کص",
"کص ننت باو",
"پدر سگ",
"سیک کن کص ننت نبینمت",
"کونده",
"ننه ولو",
"ننه سگ",
"مادر جنده",
"کص کپک زدع",
"ننع لنگی",
"ننه خیراتی",
"سجده کن سگ ننع",
"ننه خیابونی",
"ننه کارتونی",
"تکرار میکنم کص ننت",
"تلگرام تو کس ننت",
"کص خوارت",
"خوار کیونی",
"پا بزن چچچچچ",
"مادرتو گاییدم",
"گوز ننع",
"کیرم تو دهن ننت",
"ننع همگانی",
"کیرم تو کص زیدت",
"کیر تو ممهای ابجیت",
"ابجی سگ",
"کس دست ریدی با تایپ کردنت چچچ",
"ابجی جنده",
"ننع سگ سیبیل",
"بده بکنیم چچچچ",
"کص ناموس",
"شل ناموس",
"ریدم پس کلت چچچچچ",
"ننه شل",
"ننع قسطی",
"ننه ول",
"دست و پا نزن کس ننع",
"ننه ولو",
"خوارتو گاییدم",
"محوی!؟",
"ننت خوبع!؟",
"کس زنت",
"شاش ننع",
"ننه حیاطی /:",
"نن غسلی",
"کیرم تو کس ننت بگو مرسی چچچچ",
"ابم تو کص ننت :/",
"فاک یور مادر خوار سگ پخخخ",
"کیر سگ تو کص ننت",
"کص زن",
"ننه فراری",
"بکن ننتم من باو جمع کن ننه جنده /:::",
"ننه جنده بیا واسم ساک بزن",
"حرف نزن که نکنمت هااا :|",
"کیر تو کص ننت😐",
"کص کص کص ننت😂",
"کصصصص ننت جووون",
"سگ ننع",
"کص خوارت",
"کیری فیس",
"کلع کیری",
"تیز باش سیک کن نبینمت",
"فلج تیز باش چچچ",
"بیا ننتو ببر",
"بکن ننتم باو ",
"کیرم تو بدخواه",
"چچچچچچچ",
"ننه جنده",
"ننه کص طلا",
"ننه کون طلا",
"کس ننت بزارم بخندیم!؟",
"کیرم دهنت",
"مادر خراب",
"ننه کونی",
"هر چی گفتی تو کص ننت خخخخخخخ",
"کص ناموست بای",
"کص ننت بای ://",
"کص ناموست باعی تخخخخخ",
"کون گلابی!",
"ریدی آب قطع",
"کص کن ننتم کع",
"نن کونی",
"نن خوشمزه",
"ننه لوس",
" نن یه چشم ",
"ننه چاقال",
"ننه جینده",
"ننه حرصی ",
"نن لشی",
"ننه ساکر",
"نن تخمی",
"ننه بی هویت",
"نن کس",
"نن سکسی",
"نن فراری",
"لش ننه",
"سگ ننه",
"شل ننه",
"ننه تخمی",
"ننه تونلی",
"ننه کوون",
"نن خشگل",
"نن جنده",
"نن ول ",
"نن سکسی",
"نن لش",
"کس نن ",
"نن کون",
"نن رایگان",
"نن خاردار",
"ننه کیر سوار",
"نن پفیوز",
"نن محوی",
"ننه بگایی",
"ننه بمبی",
"ننه الکسیس",
"نن خیابونی",
"نن عنی",
"نن ساپورتی",
"نن لاشخور",
"ننه طلا",
"ننه عمومی",
"ننه هر جایی",
"نن دیوث",
"تخخخخخخخخخ",
"نن ریدنی",
"نن بی وجود",
"ننه سیکی",
"ننه کییر",
"نن گشاد",
"نن پولی",
"نن ول",
"نن هرزه",
"نن دهاتی",
"ننه ویندوزی",
"نن تایپی",
"نن برقی",
"نن شاشی",
"ننه درازی",
"شل ننع",
"یکن ننتم که",
"کس خوار بدخواه",
"آب چاقال",
"ننه جریده",
"ننه سگ سفید",
"آب کون",
"ننه 85",
"ننه سوپری",
"بخورش",
"کس ن",
"خوارتو گاییدم",
"خارکسده",
"گی پدر",
"آب چاقال",
"زنا زاده",
"زن جنده",
"سگ پدر",
"مادر جنده",
"ننع کیر خور",
"چچچچچ",
"تیز بالا",
"ننه سگو با کسشر در میره",
"کیر سگ تو کص ننت",

"kos kesh",
"kir",
"kiri",
"nane lashi",
"kos",
"kharet",
"blis kirmo",
"دهاتی",
"کیرم لا کص خارت",
"کیری",
"ننه لاشی",


"ممه",
"کص",
"کیر",
"بی خایه",
"ننه لش",
"بی پدرمادر",
"خارکصده",
"مادر جنده",
"کصکش",
}

reloading = {
"*Bot* _Successfully_ *Reloaded*💪\n@EssETM",
}
