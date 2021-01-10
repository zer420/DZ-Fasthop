local ui, f, n = {danger = {fasthop = gui.Keybox(gui.Reference("Misc", "Movement", "Jump"), "danger.fasthop", "FastHop", 70),},}, 0; ui.danger.fasthop:SetDescription("DZ movement exploit that makes you hop super fast.");
callbacks.Register("Draw", function()
    f = (ui.danger.fasthop:GetValue() ~= nil and ui.danger.fasthop:GetValue() ~= 0 and input.IsButtonPressed(ui.danger.fasthop:GetValue())) and 0 or f;
end);
callbacks.Register("CreateMove", function(ucmd)
    if ui.danger.fasthop:GetValue() ~= nil and ui.danger.fasthop:GetValue() ~= 0 and input.IsButtonDown(ui.danger.fasthop:GetValue()) and not gui.Reference("Menu"):IsActive() then
        -- initial jump + bhop
        ucmd.buttons = f < 2 and (f == 0 and ucmd.buttons - 4 or (f == 1 and ucmd.buttons - 2 or ucmd.buttons)) or (n and ucmd.buttons - 6 or ucmd.buttons);
        local isTouchingGround = bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0;
        -- get that speed
        ucmd.viewangles, f, n = EulerAngles(ucmd.viewangles.x, isTouchingGround and ucmd.viewangles.y + 135 or ucmd.viewangles.y, ucmd.viewangles.z), f + 1, isTouchingGround;
        gui.SetValue("misc.strafe.air", not isTouchingGround);
    end;
end);
