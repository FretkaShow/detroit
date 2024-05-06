// Discord Logging Base by @deathrow
local json = util.TableToJSON
local http
if pcall(require, 'chttp') and _G.CHTTP ~= nil then
    http = _G.CHTTP 
else
    return
end

local PM = FindMetaTable'Player'
function PM:GetURL()
    return not self:IsBot() and ('https://steamcommunity.com/profiles/%s'):format(self:SteamID64()) or 'bot'
end

local WEBHOOK_URL = "https://discord.com/api/webhooks/1221852436470300762/31nqwLOqiLO8-HPHGyBEhVFeq-GapsuYYHAXdc8uSZvnhOFlAic6hjfJ534U7AwiOpse"

local function send(data, webhook)
    webhook = webhook or WEBHOOK_URL
    http({
        url = webhook,
        type = "application/json",
        method = 'POST',
        headers = {
            ['User-Agent'] = 'curl/7.54',
        },
        body = json(data),
    })
end

function log(data, webhook)
    local _text = {
        embeds = {{
            title = data.title,
            description = data.text,
            color = data.color,
            footer = {
                text = data.tags,
            }
        }}
    }
    send(_text, webhook)
end

function log_json(text)
    http({
        url = WEBHOOK_URL,
        type = "application/json",
        method = 'POST',
        headers = {
            ['User-Agent'] = 'curl/7.54',
        },
        body = text
    })
end