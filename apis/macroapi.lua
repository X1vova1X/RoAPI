local MacroAPI = {}

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local humanoid = character:WaitForChild("Humanoid")

function MacroAPI.WalkInDirection(where, speed)
    where = where or "forward"
    speed = speed or 1

    local direction = Vector3.new(0, 0, 0)

    if where == "forward" then
        direction = Vector3.new(0, 0, -speed)
    elseif where == "left" then
        direction = Vector3.new(-speed, 0, 0)
    elseif where == "right" then
        direction = Vector3.new(speed, 0, 0)
    elseif where == "back" then
        direction = Vector3.new(0, 0, speed)
    elseif where == "forward-left" then
        direction = Vector3.new(-speed, 0, -speed)
    elseif where == "forward-right" then
        direction = Vector3.new(speed, 0, -speed)
    elseif where == "back-left" then
        direction = Vector3.new(-speed, 0, speed)
    elseif where == "back-right" then
        direction = Vector3.new(speed, 0, speed)
    else
        error("MacroAPI: Invalid choice at WalkInDirection (Choices: forward, left, right, back, forward-left, forward-right, back-left, back-right)", 1)
    end

    humanoid:Move(direction, true)
end

function MacroAPI.StopMoving()
    humanoid:Move(Vector3.new(0, 0, 0), true)
end

function MacroAPI.Jump()
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

function MacroAPI.Crouch()
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
end

function MacroAPI.StandUp()
    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

function MacroAPI.RotateTo(direction)
    local targetCFrame = CFrame.new(character.Position, character.Position + direction)
    character:SetPrimaryPartCFrame(targetCFrame)
end

function MacroAPI.SetWalkSpeed(speed)
    speed = speed or 16
    humanoid.WalkSpeed = speed
end

function MacroAPI.SetJumpPower(power)
    warn("MacroAPI: SetJumpPower is in revamping! This command might not work.")
    power = power or 100
    humanoid.JumpPower = power
end

function MacroAPI.PlayAnimation(animationId)
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()
end

function MacroAPI.FollowPath(points)
    for _, point in ipairs(points) do
        humanoid:MoveTo(point)
        humanoid.MoveToFinished:Wait()
    end
end

return MacroAPI
