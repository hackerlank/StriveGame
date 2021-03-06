require "Kbe/Interface/GameObject"

KBEngineLua.Avatar = {
	itemDict = {},
    equipItemDict = {},
};

KBEngineLua.Avatar = KBEngineLua.GameObject:New(KBEngineLua.Avatar);--继承

function KBEngineLua.Avatar:New(me) 
    me = me or {};
    setmetatable(me, self);
    self.__index = self;
    return me;
end

function KBEngineLua.Avatar:__init__( )
	if self:isPlayer() then
        Event.AddListener("relive", self.relive);
        Event.AddListener("updatePlayer", self.updatePlayer);
        Event.AddListener("sendChatMessage", self.sendChatMessage);
    end
end


function KBEngineLua.Avatar:updatePlayer(x, y, z, yaw)
    self.position.x = x;
    self.position.y = y;
    self.position.z = z;

    self.direction.z = yaw;
end

function KBEngineLua.Avatar:onEnterWorld()
    if self:isPlayer() then
        Event.Brocast("onAvatarEnterWorld", self);
    end
end

function KBEngineLua.Avatar:relive(type)
    self:cellCall({"relive", type});
end

function KBEngineLua.Avatar:sendChatMessage(msg)
    self:baseCall({"sendChatMessage", self.name .. ": " .. msg});
end

-------client method-----------------------------------
function KBEngineLua.Avatar:ReceiveChatMessage(msg)
    Event.Brocast("ReceiveChatMessage", msg);
end