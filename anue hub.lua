local Colors = {
    Background = {25, 25, 35},
    Border = {90, 90, 210},
    InnerBg = {35, 35, 45},
    InnerBg2 = {45, 45, 60},
    TitleBg = {30, 30, 40},
    Highlight = {110, 110, 255},
    Text = {255, 255, 255},
    TextSecondary = {210, 210, 210},
    Accent = {90, 90, 210},
    ButtonNormal = {45, 45, 65},
    ButtonHover = {65, 65, 85},
    ButtonPress = {35, 35, 55},
    TabActive = {70, 70, 200},
    TabInactive = {50, 50, 70}
}

local MouseService = findservice(Game, "MouseService")
local Mouse = {
    X = 0,
    Y = 0,
    Clicked = false,
    Pressed = false
}

local AnueHub = {}
local UIElements = {}
local TextElements = {}
local ButtonElements = {}
local IsVisible = true
local IsExpanded = false
local IsDragging = false
local DragOffset = {x = 0, y = 0}
local ui_transparency = 0.95
local text_transparency = 0.95
local text_size = 15
local font = 5
local HoveredButton = nil
local ActiveButton = nil
local MouseHeld = false
local LastClickTime = 0
local ExecutionCooldown = false
local ConfirmationDialogActive = false
local ScriptToExecute = nil

local original_width = 400
local original_height = 300

local expanded_width = 550
local expanded_height = 650

local anue_scripts = {
    {
        name = "MM2 ESP SCRIPT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/severe-mm2/refs/heads/main/v2"))()',
        author = "anue"
    },
    {
        name = "CRIMINALITY UI ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/crim.lua"))()',
        author = "anue"
    },
    {
        name = "FORSAKEN UI ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/forsaken"))()',
        author = "anue"
    },
    {
        name = "BGSI AUTO FARM / RIFTS ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/bgsi"))()',
        author = "anue"
    },
    {
        name = "BLOOD DEBT ESP SCRIPT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/blood-debt/refs/heads/main/ESP"))()',
        author = "anue"
    },
    {
        name = "FLEE THE FACILITY",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/flee%20the%20facility"))()',
        author = "anue"
    },
    {
        name = "FIVE NIGHTS HUNTED UI",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/FiveNightsHunted"))()',
        author = "anue"
    },
    {
        name = "THE WILD WEST ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/wildwest"))()',
        author = "anue"
    },
    {
        name = "BLOX FRUITS - FRUIT ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/fruits%20esp"))()',
        author = "anue"
    },
    {
        name = "FRONTLINES ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/frontlines"))()',
        author = "anue"
    },
    {
        name = "PROJECT REMIX SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/project%20remix"))()',
        author = "anue"
    },
    {
        name = "TRIDENT SURVIVAL SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/trident"))()',
        author = "anue"
    },
    {
        name = "FRONTLINES SUPPORT (WIP)",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Frontlines%20Support%20WIP"))()',
        author = "anue"
    },
    {
        name = "LONE SURVIVAL SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Lone%20Survival%20Support"))()',
        author = "anue"
    },
    {
        name = "GUNFIGHT ARENA SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Gunfight%20Arena"))()',
        author = "anue"
    },
    {
        name = "SKINWALKERS SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Skinswalkers"))()',
        author = "anue"
    },
    {
        name = "RAMPANT REBORN PVP SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Rampant%20Reborn"))()',
        author = "anue"
    },
    {
        name = "BOOGA BOOGA ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/booga%20booga"))()',
        author = "anue"
    }
}

local community_scripts = {
    {
        name = "DEEPWOKEN ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/deepwoken"))()',
        author = "umwfp"
    },
    {
        name = "ARSENAL",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/arsenal"))()',
        author = "roterygoose23"
    },
    {
        name = "INF JUMP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/inf%20jump"))()',
        author = "king bob"
    },
    {
        name = "UNIVERSAL MOD CHECKER",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/UNIVERSAL%20MOD%20CHECKER"))()',
        author = "getchildren"
    },
    {
        name = "LOCK'S NPC AIMBOT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/NotLockTheHobo/LocksNpcAimbot/refs/heads/main/games/severe/sv_lna_baseplate.lua"))()',
        author = "lock"
    },
    {
        name = "DEAD RAILS ITEM ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Dead%20Rails"))()',
        author = "q379"
    },
    {
        name = "BRM5",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/BRM5.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "DEADLINE",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Deadline"))()',
        author = "bernard the butcher"
    },
    {
        name = "LONE SURVIVAL",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/LONE%20SURVIVAL"))()',
        author = "shimotvink"
    },
    {
        name = "FISCH",
        loadstring = 'loadstring(game:HttpGet("https://i-am.injured.lol/p/raw/686nyqgmlq"))()',
        author = "Alex - vantareal"
    },
    {
        name = "MTC4 INFINITE MAG AMMO",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/MTC4"))()',
        author = "bernard the butcher"
    },
    {
        name = "COUNTER BLOX GUN MODS",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/CounterBlox"))()',
        author = "peke"
    },
    {
        name = "AFTERMATH ZOMBIES AIMBOT/ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Aftermath%20Zombies"))()',
        author = "9zs"
    },
    {
        name = "DEADLINE SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/Deadline.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "BRM5 SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/BRM5.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "AOT: FREEDOM WAR UI",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/1byp4/Severe/refs/heads/main/AOT%20Freedom%20War.lua"))()',
        author = "1byp4"
    },
    {
        name = "DEAD RAILS PARTIAL SUPPORT (ZOMBIES)",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sen-jp/Severe-Luas/refs/heads/main/Deadrails.lua"))()',
        author = "sen"
    },
    {
        name = "JUMPHEIGHT BOOST FOR FF2",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sen-jp/Severe-Luas/refs/heads/main/FootballFusion2.lua"))()',
        author = "sen"
    },
    {
        name = "SCORCHED EARTH SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/ScorchedEarth"))()',
        author = "bernard the butcher"
    },
    {
        name = "ARMSOFSOLITAIRE",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/ArmsOfSolitaire"))()',
        author = "bernard the butcher"
    },
    {
        name = "POSSESOR SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Possesor"))()',
        author = "Opokeu"
    },
    {
        name = "AFTERMATH SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/minions638/severe-lua/refs/heads/main/aftermath.lua"))()',
        author = "umwfp"
    },
    {
        name = "RIOTFALL [BETA] SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sen-jp/Severe-Luas/refs/heads/main/RIOTFALL.lua"))()',
        author = "sen"
    },
    {
        name = "RUSH POINT SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sen-jp/Severe-Luas/refs/heads/main/RushPoint.lua"))()',
        author = "sen"
    },
    {
        name = "FRONTLINES SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sen-jp/Severe-Luas/refs/heads/main/Frontlines.lua"))()',
        author = "sen"
    },
    {
        name = "POSSESOR SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Possesor"))()',
        author = "Opokeu"
    },
    {
        name = "INVISIBLE CHECK",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/INVISIBLE%20CHECK"))()',
        author = "1byp4"
    },
    {
        name = "NPC GAME SUPPORT",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/NPC.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "QUICK SAVE",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Quick%20Save"))()',
        author = "king bob"
    },
    {
        name = "THE WILD WEST GAME SUPPORT - PLAYERS AND ANIMALS",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/TheWildWest.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "THE WILD WEST GAME SUPPORT - ORES",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/fawk/refs/heads/main/TheWildWestOres.lua"))()',
        author = "bernard the butcher"
    },
    {
        name = "FREECAM",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/Freecam"))()',
        author = "x88"
    },
    {
        name = "RIVALS GUN ESP",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/lrd14/rivals-testing/refs/heads/main/main.lua"))()',
        author = "bertu"
    },
    {
        name = "AOT FW",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/AOT%20FW"))()',
        author = "Pork"
    }
}

local selected_index = 1
local selected_tab = 1
local current_page = 1
local max_items_per_page = 9
local SCREEN_DIMENSIONS = getscreendimensions()
local ui_running = true

local IsHovering = false 
local MouseHoverIndex = nil 

local FloatingLogo = nil 
local FloatingLogoBg = nil 
local FloatingLogoBorder = nil 

local ConfirmationDialogElements = {}

function AnueHub:Init()

local new_community_scripts = {
    {
        name = "More Scripts Coming Soon!",
        loadstring = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/anue1337/ui/refs/heads/main/a"))()',
        author = "o.O"
    }
}

    self:CreateFloatingLogo()

    self:CreateMainWindow()
    self:CreateContentArea()
    self:CreateElementPropertiesTracker()
    self:CreateControlButtons()
    self:CreateTabsSystem()
    self:CreateHelpTexts()
    self:CreateTitleHoverIndicator()

    if self.ExpandButton then
        self._expandButtonText = self.ExpandButton.Text
    end

    if self.CloseButton then
        self._closeButtonText = self.CloseButton.Text
    end

    self:AddCommunityScripts(new_community_scripts)

    self:RegisterInputHandlers()
    self:HandleButtonInteractions()

    self:UpdateLayout()

    return self
end

function AnueHub:CreateFloatingLogo()

    FloatingLogoBg = Drawing.new("Circle")
    FloatingLogoBg.Filled = true
    FloatingLogoBg.NumSides = 30 
    FloatingLogoBg.Radius = 25

    FloatingLogoBg.Position = {SCREEN_DIMENSIONS.x / 2, 100} 
    FloatingLogoBg.Color = {30, 30, 40} 
    FloatingLogoBg.Transparency = 0.85
    FloatingLogoBg.Visible = false
    table.insert(UIElements, FloatingLogoBg)

    FloatingLogoBorder = Drawing.new("Circle") 
    FloatingLogoBorder.Filled = false
    FloatingLogoBorder.NumSides = 30
    FloatingLogoBorder.Radius = 25
    FloatingLogoBorder.Thickness = 2
    FloatingLogoBorder.Position = {SCREEN_DIMENSIONS.x / 2, 100} 
    FloatingLogoBorder.Color = Colors.Border
    FloatingLogoBorder.Transparency = 0.9
    FloatingLogoBorder.Visible = false
    table.insert(UIElements, FloatingLogoBorder)

    FloatingLogo = Drawing.new("Image")
    FloatingLogo.Url = "https://cdn.nest.rip/uploads/17230644-70b2-4de4-aa2b-17e23bc47a8c.png"
    FloatingLogo.Size = {35, 35}

    FloatingLogo.Position = {SCREEN_DIMENSIONS.x / 2 - 17.5, 100 - 17.5} 
    FloatingLogo.Transparency = 1
    FloatingLogo.Visible = false
    table.insert(UIElements, FloatingLogo)

    local isHovered = false

    spawn(function()
        local selfRef = self 
        while ui_running do
            if not IsVisible and FloatingLogo and FloatingLogo.Visible then
                local mouse_pos = getmouseposition()

                local is_over_logo = 
                    math.sqrt((mouse_pos.x - FloatingLogoBg.Position.x)^2 + 
                              (mouse_pos.y - FloatingLogoBg.Position.y)^2) <= FloatingLogoBg.Radius

                if is_over_logo and not isHovered then
                    isHovered = true

                    spawn(function()
                        local start_radius = FloatingLogoBg.Radius
                        local target_radius = 27
                        local duration = 0.2
                        local start_time = time()

                        while time() - start_time < duration and ui_running and isHovered do
                            local progress = (time() - start_time) / duration
                            local eased = progress * (2 - progress) 
                            local current = start_radius + (target_radius - start_radius) * eased

                            FloatingLogoBg.Radius = current
                            FloatingLogoBorder.Radius = current

                            FloatingLogoBg.Color = {
                                30 + 20 * eased,
                                30 + 20 * eased,
                                40 + 30 * eased
                            }

                            local newSize = 35 + 5 * eased
                            FloatingLogo.Size = {newSize, newSize}
                            FloatingLogo.Position = {
                                SCREEN_DIMENSIONS.x / 2 - newSize / 2,
                                100 - newSize / 2
                            }

                            wait(0.01)
                        end
                    end)
                elseif not is_over_logo and isHovered then
                    isHovered = false

                    spawn(function()
                        local start_radius = FloatingLogoBg.Radius
                        local target_radius = 25
                        local duration = 0.2
                        local start_time = time()

                        while time() - start_time < duration and ui_running and not isHovered do
                            local progress = (time() - start_time) / duration
                            local eased = progress * (2 - progress) 
                            local current = start_radius + (target_radius - start_radius) * eased

                            FloatingLogoBg.Radius = current
                            FloatingLogoBorder.Radius = current

                            FloatingLogoBg.Color = {
                                math.max(30, FloatingLogoBg.Color and FloatingLogoBg.Color[1] and FloatingLogoBg.Color[1] - 20 * eased or 30),
                                math.max(30, FloatingLogoBg.Color and FloatingLogoBg.Color[2] and FloatingLogoBg.Color[2] - 20 * eased or 30),
                                math.max(40, FloatingLogoBg.Color and FloatingLogoBg.Color[3] and FloatingLogoBg.Color[3] - 30 * eased or 40)
                            }

                            local newSize = math.max(35, FloatingLogo.Size.x - 5 * eased)
                            FloatingLogo.Size = {newSize, newSize}
                            FloatingLogo.Position = {
                                SCREEN_DIMENSIONS.x / 2 - newSize / 2,
                                100 - newSize / 2
                            }

                            wait(0.01)
                        end

                        if not isHovered then
                            FloatingLogoBg.Radius = 25
                            FloatingLogoBorder.Radius = 25
                            FloatingLogoBg.Color = {30, 30, 40}
                            FloatingLogo.Size = {35, 35}
                            FloatingLogo.Position = {SCREEN_DIMENSIONS.x / 2 - 17.5, 100 - 17.5}
                        end
                    end)
                end

                if is_over_logo and isleftclicked() then
                    selfRef:ToggleUI() 
                end
            end

            wait(0.01)
        end
    end)
end

function AnueHub:CreateMainWindow()

    self.MainFrame = Drawing.new("Square")
    self.MainFrame.Filled = true
    self.MainFrame.Visible = true
    self.MainFrame.Size = {original_width, original_height}
    self.MainFrame.Position = {
        20,
        SCREEN_DIMENSIONS.y / 2 - original_height / 2
    }
    self.MainFrame.Color = Colors.Background
    self.MainFrame.Transparency = ui_transparency
    table.insert(UIElements, self.MainFrame)

    self.BorderFrame = self:CreateFrame(self.MainFrame, 2, Colors.Border)
    self.InnerFrame = self:CreateFrame(self.BorderFrame, 3, Colors.Background)
    self.ContentBg = self:CreateFrame(self.InnerFrame, 3, Colors.InnerBg)

    self:CreateCorners()

    self.TitleBar = Drawing.new("Square")
    self.TitleBar.Filled = true
    self.TitleBar.Visible = true
    self.TitleBar.Size = {self.ContentBg.Size.x - 10, 26} 
    self.TitleBar.Position = {self.ContentBg.Position.x + 5, self.ContentBg.Position.y + 5}
    self.TitleBar.Color = Colors.TitleBg
    self.TitleBar.Transparency = ui_transparency
    table.insert(UIElements, self.TitleBar)

    self.TitleBarAccent = Drawing.new("Square")
    self.TitleBarAccent.Filled = true
    self.TitleBarAccent.Visible = true
    self.TitleBarAccent.Size = {self.TitleBar.Size.x, 2}
    self.TitleBarAccent.Position = {
        self.TitleBar.Position.x,
        self.TitleBar.Position.y + self.TitleBar.Size.y
    }
    self.TitleBarAccent.Color = Colors.Accent
    self.TitleBarAccent.Transparency = ui_transparency * 0.8
    table.insert(UIElements, self.TitleBarAccent)

    self.TitleText = Drawing.new("Text")
    self.TitleText.Text = ""  
    self.TitleText.Visible = true
    self.TitleText.Color = Colors.Highlight
    self.TitleText.Size = 18
    self.TitleText.Font = 5
    self.TitleText.Transparency = text_transparency

    self.TitleText.Position = {
        self.TitleBar.Position.x + self.TitleBar.Size.x / 2,
        self.TitleBar.Position.y + 10
    }
    self.TitleText.Center = true
    self.TitleText.Outline = true
    table.insert(TextElements, self.TitleText)

    self.TitleGlow = Drawing.new("Text")
    self.TitleGlow.Text = ""  
    self.TitleGlow.Visible = true
    self.TitleGlow.Color = {Colors.Highlight[1] * 0.7, Colors.Highlight[2] * 0.7, Colors.Highlight[3] * 0.7}
    self.TitleGlow.Size = 18
    self.TitleGlow.Font = 5
    self.TitleGlow.Transparency = text_transparency * 0.6
    self.TitleGlow.Position = {
        self.TitleBar.Position.x + self.TitleBar.Size.x / 2 + 1,
        self.TitleBar.Position.y + 11
    }
    self.TitleGlow.Center = true
    table.insert(TextElements, self.TitleGlow)

    self.TitleLogo = Drawing.new("Image")
    self.TitleLogo.Url = "https://cdn.nest.rip/uploads/17230644-70b2-4de4-aa2b-17e23bc47a8c.png"
    self.TitleLogo.Visible = true
    self.TitleLogo.Size = {20, 20} 
    self.TitleLogo.Position = {
        self.ContentBg.Position.x + 10,
        self.ContentBg.Position.y + 6
    }
    self.TitleLogo.Transparency = 1
    table.insert(UIElements, self.TitleLogo)

    self.VersionText = Drawing.new("Text")
    self.VersionText.Text = "v2.0"
    self.VersionText.Visible = true
    self.VersionText.Color = Colors.TextSecondary
    self.VersionText.Size = 12
    self.VersionText.Font = 5
    self.VersionText.Transparency = text_transparency * 0.7

    self.VersionText.Position = {0, 0} 
    table.insert(TextElements, self.VersionText)

end

function AnueHub:CreateFrame(parent, offset, color)
    local frame = Drawing.new("Square")
    frame.Filled = true
    frame.Visible = true
    frame.Size = {parent.Size.x - offset, parent.Size.y - offset}
    frame.Position = {parent.Position.x + offset/2, parent.Position.y + offset/2}
    frame.Color = color
    frame.Transparency = ui_transparency
    table.insert(UIElements, frame)
    return frame
end

function AnueHub:CreateCorners()

    self.TopLeft = Drawing.new("Square")
    self.TopLeft.Filled = true
    self.TopLeft.Visible = true
    self.TopLeft.Size = {10, 10}
    self.TopLeft.Position = {self.MainFrame.Position.x - 5, self.MainFrame.Position.y - 5}
    self.TopLeft.Color = Colors.Border
    self.TopLeft.Transparency = ui_transparency * 0.7
    table.insert(UIElements, self.TopLeft)

    self.TopRight = Drawing.new("Square")
    self.TopRight.Filled = true
    self.TopRight.Visible = true
    self.TopRight.Size = {10, 10}
    self.TopRight.Position = {self.MainFrame.Position.x + self.MainFrame.Size.x - 5, self.MainFrame.Position.y - 5}
    self.TopRight.Color = Colors.Border
    self.TopRight.Transparency = ui_transparency * 0.7
    table.insert(UIElements, self.TopRight)

    self.BottomLeft = Drawing.new("Square")
    self.BottomLeft.Filled = true
    self.BottomLeft.Visible = true
    self.BottomLeft.Size = {10, 10}
    self.BottomLeft.Position = {self.MainFrame.Position.x - 5, self.MainFrame.Position.y + self.MainFrame.Size.y - 5}
    self.BottomLeft.Color = Colors.Border
    self.BottomLeft.Transparency = ui_transparency * 0.7
    table.insert(UIElements, self.BottomLeft)

    self.BottomRight = Drawing.new("Square")
    self.BottomRight.Filled = true
    self.BottomRight.Visible = true
    self.BottomRight.Size = {10, 10}
    self.BottomRight.Position = {self.MainFrame.Position.x + self.MainFrame.Size.x - 5, self.MainFrame.Position.y + self.MainFrame.Size.y - 5}
    self.BottomRight.Color = Colors.Border
    self.BottomRight.Transparency = ui_transparency * 0.7
    table.insert(UIElements, self.BottomRight)
end

function AnueHub:CreateTabsSystem()

    self.TabAnueButton = self:CreateButton({
        position = {self.ContentBg.Position.x + 15, self.TitleBar.Position.y + self.TitleBar.Size.y + 5},
        size = {120, 25},
        text = "Anue Scripts (F1)",
        textSize = 13,
        color = selected_tab == 1 and Colors.TabActive or Colors.TabInactive,
        hoverColor = Colors.ButtonHover,
        pressColor = Colors.ButtonPress,
        borderColor = selected_tab == 1 and Colors.Highlight or Colors.Border,
        borderHoverColor = Colors.Highlight,
        visible = false,
        callback = function()

            pcall(function()
                if selected_tab ~= 1 then
                    self:SelectTab(1)
                end
            end)
        end
    })

    self.TabCommunityButton = self:CreateButton({
        position = {self.ContentBg.Position.x + 145, self.TitleBar.Position.y + self.TitleBar.Size.y + 5},
        size = {150, 25},
        text = "Community Scripts (F2)",
        textSize = 13,
        color = selected_tab == 2 and Colors.TabActive or Colors.TabInactive,
        hoverColor = Colors.ButtonHover,
        pressColor = Colors.ButtonPress,
        borderColor = selected_tab == 2 and Colors.Highlight or Colors.Border,
        borderHoverColor = Colors.Highlight,
        visible = false,
        callback = function()

            pcall(function()
                if selected_tab ~= 2 then
                    self:SelectTab(2)
                end
            end)
        end
    })

    self.TabIndicator = Drawing.new("Square")
    self.TabIndicator.Filled = true
    self.TabIndicator.Visible = false
    self.TabIndicator.Size = {120, 2}
    self.TabIndicator.Color = Colors.Highlight
    self.TabIndicator.Transparency = 1
    self.TabIndicator.Position = {
        self.TabAnueButton.Background.Position.x,
        self.TabAnueButton.Background.Position.y + self.TabAnueButton.Background.Size.y
    }
    table.insert(UIElements, self.TabIndicator)

    self.PageIndicator = Drawing.new("Text")
    self.PageIndicator.Text = "Page 1/1"
    self.PageIndicator.Visible = false
    self.PageIndicator.Center = false
    self.PageIndicator.Color = Colors.TextSecondary
    self.PageIndicator.Size = 13
    self.PageIndicator.Font = font
    self.PageIndicator.Transparency = text_transparency

    if self.ContentFrame then
        self.PageIndicator.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x - 60,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 20
        }
    else

        self.PageIndicator.Position = {
            self.ContentBg.Position.x + self.ContentBg.Size.x - 60,
            self.ContentBg.Position.y + self.ContentBg.Size.y - 20
        }
    end
    table.insert(TextElements, self.PageIndicator)

    self.PrevPageButton = self:CreateButton({
        position = {
            self.ContentFrame.Position.x + 10,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 35
        },
        size = {80, 25},
        text = "< Prev",
        textSize = 13,
        color = {40, 40, 60},
        hoverColor = {60, 60, 100},
        pressColor = {30, 30, 50},
        borderColor = {60, 60, 80},
        borderHoverColor = {100, 100, 200},
        visible = false,
        callback = function()

            pcall(function()
                if current_page > 1 then
                    current_page = current_page - 1
                    selected_index = 1
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                end
            end)
        end
    })

    self.NextPageButton = self:CreateButton({
        position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x - 90,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 35
        },
        size = {80, 25},
        text = "Next >",
        textSize = 13,
        color = {40, 40, 60},
        hoverColor = {60, 60, 100},
        pressColor = {30, 30, 50},
        borderColor = {60, 60, 80},
        borderHoverColor = {100, 100, 200},
        visible = false,
        callback = function()

            pcall(function()
                local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
                local total_pages = math.ceil(#active_scripts / max_items_per_page)
                if current_page < total_pages then
                    current_page = current_page + 1
                    selected_index = 1
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                end
            end)
        end
    })
end

function AnueHub:CreateContentArea()

    self.ContentFrame = Drawing.new("Square")
    self.ContentFrame.Filled = true
    self.ContentFrame.Visible = true
    self.ContentFrame.Size = {self.ContentBg.Size.x - 10, self.ContentBg.Size.y - 41} 
    self.ContentFrame.Position = {
        self.ContentBg.Position.x + 5,
        self.TitleBar.Position.y + self.TitleBar.Size.y + 5
    }
    self.ContentFrame.Color = {25, 25, 25}
    self.ContentFrame.Transparency = ui_transparency
    table.insert(UIElements, self.ContentFrame)

    self.ContentFrameBorder = Drawing.new("Square")
    self.ContentFrameBorder.Filled = false
    self.ContentFrameBorder.Visible = true
    self.ContentFrameBorder.Size = {self.ContentFrame.Size.x, self.ContentFrame.Size.y}
    self.ContentFrameBorder.Position = {self.ContentFrame.Position.x, self.ContentFrame.Position.y}
    self.ContentFrameBorder.Color = Colors.Border
    self.ContentFrameBorder.Thickness = 1
    self.ContentFrameBorder.Transparency = ui_transparency * 0.5
    table.insert(UIElements, self.ContentFrameBorder)

    self.WelcomeDecorTop = Drawing.new("Square")
    self.WelcomeDecorTop.Filled = true
    self.WelcomeDecorTop.Visible = true
    self.WelcomeDecorTop.Size = {120, 3}
    self.WelcomeDecorTop.Color = Colors.Accent
    self.WelcomeDecorTop.Transparency = ui_transparency * 0.9
    self.WelcomeDecorTop.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 60,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 - 50
    }
    table.insert(UIElements, self.WelcomeDecorTop)

    self.WelcomeDecorBottom = Drawing.new("Square")
    self.WelcomeDecorBottom.Filled = true
    self.WelcomeDecorBottom.Visible = true
    self.WelcomeDecorBottom.Size = {120, 3}
    self.WelcomeDecorBottom.Color = Colors.Accent
    self.WelcomeDecorBottom.Transparency = ui_transparency * 0.9
    self.WelcomeDecorBottom.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 60,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 + 30
    }
    table.insert(UIElements, self.WelcomeDecorBottom)

    self.WelcomeLogo = Drawing.new("Image")
    self.WelcomeLogo.Url = "https://cdn.nest.rip/uploads/17230644-70b2-4de4-aa2b-17e23bc47a8c.png"
    self.WelcomeLogo.Visible = true
    self.WelcomeLogo.Size = {70, 70} 
    self.WelcomeLogo.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 35,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 - 50  
    }
    self.WelcomeLogo.Transparency = 1
    table.insert(UIElements, self.WelcomeLogo)

    self.WelcomeText = Drawing.new("Text")
    self.WelcomeText.Text = "WELCOME TO ANUE SEVERE HUB"  
    self.WelcomeText.Visible = true
    self.WelcomeText.Center = true
    self.WelcomeText.Color = Colors.Highlight
    self.WelcomeText.Size = text_size + 1
    self.WelcomeText.Font = font
    self.WelcomeText.Transparency = text_transparency
    self.WelcomeText.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 + 10  
    }
    self.WelcomeText.Outline = true
    table.insert(TextElements, self.WelcomeText)

    self.WelcomeVersionText = Drawing.new("Text")
    self.WelcomeVersionText.Text = "Version 2.0"  
    self.WelcomeVersionText.Visible = true
    self.WelcomeVersionText.Center = true
    self.WelcomeVersionText.Color = {Colors.TextSecondary[1] * 0.8, Colors.TextSecondary[2] * 0.8, Colors.TextSecondary[3] * 0.8}
    self.WelcomeVersionText.Size = text_size - 2
    self.WelcomeVersionText.Font = font
    self.WelcomeVersionText.Transparency = text_transparency * 0.7
    self.WelcomeVersionText.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y - 40
    }
    table.insert(TextElements, self.WelcomeVersionText)

    self.EnterButton = self:CreateButton({
        position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 50,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 80
        },
        size = {100, 25},
        text = "ENTER",
        textSize = 14,
        color = {40, 40, 60},
        hoverColor = {60, 60, 100},
        pressColor = {30, 30, 50},
        borderColor = {60, 60, 80},
        borderHoverColor = {100, 100, 200},
        visible = false,
        callback = function()

            pcall(function()
                if not IsExpanded then
                    self:ToggleExpanded()
                end
            end)
        end
    })

    self.LogoFrame = Drawing.new("Square")
    self.LogoFrame.Filled = true
    self.LogoFrame.Visible = false
    self.LogoFrame.Size = {self.ContentBg.Size.x - 20, 30}
    self.LogoFrame.Position = {self.ContentBg.Position.x + 10, self.ContentBg.Position.y + 40}
    self.LogoFrame.Color = Colors.InnerBg2
    self.LogoFrame.Transparency = ui_transparency * 0.9
    table.insert(UIElements, self.LogoFrame)

    self.LogoBorder = Drawing.new("Square")
    self.LogoBorder.Filled = false
    self.LogoBorder.Visible = false
    self.LogoBorder.Size = {self.LogoFrame.Size.x, self.LogoFrame.Size.y}
    self.LogoBorder.Position = {self.LogoFrame.Position.x, self.LogoFrame.Position.y}
    self.LogoBorder.Color = Colors.Border
    self.LogoBorder.Thickness = 1.5
    self.LogoBorder.Transparency = ui_transparency * 0.9
    table.insert(UIElements, self.LogoBorder)

    self.LogoImage = Drawing.new("Image")
    self.LogoImage.Url = "https://cdn.nest.rip/uploads/17230644-70b2-4de4-aa2b-17e23bc47a8c.png"
    self.LogoImage.Visible = false  
    self.LogoImage.Size = {30, 30} 
    self.LogoImage.Position = {
        self.LogoFrame.Position.x + self.LogoFrame.Size.x / 2 - 15,
        self.LogoFrame.Position.y
    }
    self.LogoImage.Transparency = 1
    table.insert(UIElements, self.LogoImage)

    self.LogoText = Drawing.new("Text")
    self.LogoText.Text = "ANUE SEVERE HUB"
    self.LogoText.Visible = false  
    self.LogoText.Center = true
    self.LogoText.Color = Colors.Highlight
    self.LogoText.Size = text_size + 3
    self.LogoText.Font = font
    self.LogoText.Transparency = text_transparency  
    self.LogoText.Position = {
        self.LogoFrame.Position.x + self.LogoFrame.Size.x / 2,
        self.LogoFrame.Position.y + self.LogoFrame.Size.y / 2 - 8
    }
    table.insert(TextElements, self.LogoText)

    self.SelectionHighlight = Drawing.new("Square")
    self.SelectionHighlight.Filled = true
    self.SelectionHighlight.Visible = false
    self.SelectionHighlight.Size = {self.ContentFrame.Size.x - 20, 45} 
    self.SelectionHighlight.Color = Colors.Highlight
    self.SelectionHighlight.Transparency = 0.15
    table.insert(UIElements, self.SelectionHighlight)

    self.ScriptOptions = {}
    self.AuthorLabels = {}
    self:CreateScriptOptions()
end

function AnueHub:CreateScriptOptions()
    local start_y = self.LogoFrame.Position.y + self.LogoFrame.Size.y + 15
    local option_spacing = 55  

    for i, option in ipairs(anue_scripts) do
        local text = Drawing.new("Text")
        text.Text = option.name
        text.Visible = false
        text.Color = Colors.Text
        text.Size = text_size
        text.Font = font
        text.Transparency = text_transparency
        text.Position = {
            self.ContentFrame.Position.x + 25,
            start_y + (i-1) % max_items_per_page * option_spacing
        }
        table.insert(self.ScriptOptions, text)
        table.insert(TextElements, text)

        local author_text = Drawing.new("Text")
        author_text.Text = "by " .. option.author
        author_text.Visible = false
        author_text.Color = {180, 180, 255}  
        author_text.Size = text_size - 2     
        author_text.Font = font
        author_text.Transparency = text_transparency
        author_text.Position = {
            self.ContentFrame.Position.x + 30,
            start_y + (i-1) % max_items_per_page * option_spacing + 20  
        }
        table.insert(self.AuthorLabels, author_text)
        table.insert(TextElements, author_text)

        local execute_button = self:CreateButton({
            position = {
                self.ContentFrame.Position.x + self.ContentFrame.Size.x - 120, 
                start_y + (i-1) % max_items_per_page * option_spacing + 5 
            },
            size = {85, 25}, 
            text = "Execute",
            textSize = 12,
            color = {90, 90, 210}, 
            hoverColor = {110, 110, 255}, 
            pressColor = {70, 70, 180}, 
            borderColor = {100, 100, 230}, 
            borderHoverColor = {130, 130, 255}, 
            visible = false,
            callback = function()
                if i <= #anue_scripts then
                    self:ExecuteScript(anue_scripts[i])
                end
            end
        })

        anue_scripts[i].ExecuteButton = execute_button
    end

    local offset = #anue_scripts
    for i, option in ipairs(community_scripts) do
        local text = Drawing.new("Text")
        text.Text = option.name
        text.Visible = false
        text.Color = Colors.Text
        text.Size = text_size
        text.Font = font
        text.Transparency = text_transparency
        text.Position = {
            self.ContentFrame.Position.x + 25,
            start_y + (i-1) % max_items_per_page * option_spacing
        }
        table.insert(self.ScriptOptions, text)
        table.insert(TextElements, text)

        local author_text = Drawing.new("Text")
        author_text.Text = "by " .. option.author
        author_text.Visible = false
        author_text.Color = {180, 180, 255}  
        author_text.Size = text_size - 2     
        author_text.Font = font
        author_text.Transparency = text_transparency
        author_text.Position = {
            self.ContentFrame.Position.x + 30,
            start_y + (i-1) % max_items_per_page * option_spacing + 20  
        }
        table.insert(self.AuthorLabels, author_text)
        table.insert(TextElements, author_text)

        local execute_button = self:CreateButton({
            position = {
                self.ContentFrame.Position.x + self.ContentFrame.Size.x - 120, 
                start_y + (i-1) % max_items_per_page * option_spacing + 5
            },
            size = {85, 25}, 
            text = "Execute",
            textSize = 12,
            color = {90, 90, 210}, 
            hoverColor = {110, 110, 255}, 
            pressColor = {70, 70, 180}, 
            borderColor = {100, 100, 230}, 
            borderHoverColor = {130, 130, 255}, 
            visible = false,
            callback = function()
                self:ExecuteScript(community_scripts[i])
            end
        })

        community_scripts[i].ExecuteButton = execute_button
    end
end

function AnueHub:CreateHelpTexts()
    self.GuideTexts = {}

    self.OpenCloseGuide = Drawing.new("Text")
    self.OpenCloseGuide.Text = "Press [HOME] to open hub"
    self.OpenCloseGuide.Visible = true
    self.OpenCloseGuide.Center = true
    self.OpenCloseGuide.Color = {130, 130, 255} 
    self.OpenCloseGuide.Size = 16 
    self.OpenCloseGuide.Font = 5
    self.OpenCloseGuide.Transparency = 1 
    self.OpenCloseGuide.Position = {SCREEN_DIMENSIONS.x / 2, 20}
    self.OpenCloseGuide.Outline = true

    self.OpenCloseGuideShadow = Drawing.new("Text")
    self.OpenCloseGuideShadow.Text = "Press [HOME] to open hub"
    self.OpenCloseGuideShadow.Visible = true
    self.OpenCloseGuideShadow.Center = true
    self.OpenCloseGuideShadow.Color = {20, 20, 30} 
    self.OpenCloseGuideShadow.Size = 16
    self.OpenCloseGuideShadow.Font = 5
    self.OpenCloseGuideShadow.Transparency = 1
    self.OpenCloseGuideShadow.Position = {SCREEN_DIMENSIONS.x / 2 + 1, 20 + 1} 

    table.insert(self.GuideTexts, self.OpenCloseGuideShadow)
    table.insert(TextElements, self.OpenCloseGuideShadow)
    table.insert(self.GuideTexts, self.OpenCloseGuide)
    table.insert(TextElements, self.OpenCloseGuide)

    self.ExpandGuide = Drawing.new("Text")
    self.ExpandGuide.Text = "Press [ENTER] to expand menu"
    self.ExpandGuide.Visible = false
    self.ExpandGuide.Center = true
    self.ExpandGuide.Color = {130, 130, 255} 
    self.ExpandGuide.Size = 16 
    self.ExpandGuide.Font = 5
    self.ExpandGuide.Transparency = 1 
    self.ExpandGuide.Position = {SCREEN_DIMENSIONS.x / 2, 45} 
    self.ExpandGuide.Outline = true

    self.ExpandGuideShadow = Drawing.new("Text")
    self.ExpandGuideShadow.Text = "Press [ENTER] to expand menu"
    self.ExpandGuideShadow.Visible = false
    self.ExpandGuideShadow.Center = true
    self.ExpandGuideShadow.Color = {20, 20, 30} 
    self.ExpandGuideShadow.Size = 16
    self.ExpandGuideShadow.Font = 5
    self.ExpandGuideShadow.Transparency = 1
    self.ExpandGuideShadow.Position = {SCREEN_DIMENSIONS.x / 2 + 1, 45 + 1} 

    table.insert(self.GuideTexts, self.ExpandGuideShadow)
    table.insert(TextElements, self.ExpandGuideShadow)
    table.insert(self.GuideTexts, self.ExpandGuide)
    table.insert(TextElements, self.ExpandGuide)

    self.NavigationGuide = Drawing.new("Text")
    self.NavigationGuide.Text = "Use [UP/DOWN] to navigate, [LEFT/RIGHT] to change page, [Y] to select script"
    self.NavigationGuide.Visible = false
    self.NavigationGuide.Center = true
    self.NavigationGuide.Color = {130, 130, 255} 
    self.NavigationGuide.Size = 16 
    self.NavigationGuide.Font = 5
    self.NavigationGuide.Transparency = 1 
    self.NavigationGuide.Position = {SCREEN_DIMENSIONS.x / 2, 45} 
    self.NavigationGuide.Outline = true

    self.NavigationGuideShadow = Drawing.new("Text")
    self.NavigationGuideShadow.Text = "Use [UP/DOWN] to navigate, [LEFT/RIGHT] to change page, [Y] to select script"
    self.NavigationGuideShadow.Visible = false
    self.NavigationGuideShadow.Center = true
    self.NavigationGuideShadow.Color = {20, 20, 30} 
    self.NavigationGuideShadow.Size = 16
    self.NavigationGuideShadow.Font = 5
    self.NavigationGuideShadow.Transparency = 1
    self.NavigationGuideShadow.Position = {SCREEN_DIMENSIONS.x / 2 + 1, 45 + 1} 

    table.insert(self.GuideTexts, self.NavigationGuideShadow)
    table.insert(TextElements, self.NavigationGuideShadow)
    table.insert(self.GuideTexts, self.NavigationGuide)
    table.insert(TextElements, self.NavigationGuide)
end

function AnueHub:UpdateCornerPositions()
    local x = self.MainFrame.Position.x
    local y = self.MainFrame.Position.y
    local width = self.MainFrame.Size.x
    local height = self.MainFrame.Size.y

    self.TopLeft.Position = {x - 5, y - 5}
    self.TopRight.Position = {x + width - 5, y - 5}
    self.BottomLeft.Position = {x - 5, y + height - 5}
    self.BottomRight.Position = {x + width - 5, y + height - 5}
end

function AnueHub:UpdateLayout()

    self.BorderFrame.Position = {self.MainFrame.Position.x + 2.5/2, self.MainFrame.Position.y + 2.5/2}

    self.InnerFrame.Position = {self.BorderFrame.Position.x + 3/2, self.BorderFrame.Position.y + 3/2}

    self.ContentBg.Position = {self.InnerFrame.Position.x + 3/2, self.InnerFrame.Position.y + 3/2}

    self.TitleBar.Position = {self.ContentBg.Position.x + 5, self.ContentBg.Position.y + 5}

    self.TitleText.Position = {
        self.TitleBar.Position.x + self.TitleBar.Size.x / 2,
        self.TitleBar.Position.y + 10
    }

    if self.TitleGlow then
        self.TitleGlow.Position = {
            self.TitleBar.Position.x + self.TitleBar.Size.x / 2 + 1,
            self.TitleBar.Position.y + 11
        }
    end

    if self.TitleLogo then
        self.TitleLogo.Position = {
            self.ContentBg.Position.x + 10,
            self.ContentBg.Position.y + 6
        }
    end

    self.ContentFrame.Position = {
        self.ContentBg.Position.x + 5,
        self.TitleBar.Position.y + self.TitleBar.Size.y + 5
    }

    self.WelcomeText.Position = {
        self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2,
        self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 + 10  
    }

    if self.WelcomeVersionText then
        self.WelcomeVersionText.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 40
        }
    end

    if self.WelcomeDecorTop then
        self.WelcomeDecorTop.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 60,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 - 50
        }
    end

    if self.WelcomeDecorBottom then
        self.WelcomeDecorBottom.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 60,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 + 30
        }
    end

    if self.WelcomeLogo then
        self.WelcomeLogo.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 35,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y / 2 - 50  
        }
    end

    if IsExpanded and self.TabAnueButton and self.TabAnueButton.Background then

        pcall(function()

            self.TabAnueButton.Background.Position = {
                self.ContentBg.Position.x + 15, 
                self.TitleBar.Position.y + self.TitleBar.Size.y + 5
            }

            self.TabCommunityButton.Background.Position = {
                self.ContentBg.Position.x + 145, 
                self.TitleBar.Position.y + self.TitleBar.Size.y + 5
            }

            self:UpdateButtonTextPosition(self.TabAnueButton)
            self:UpdateButtonTextPosition(self.TabCommunityButton)
        end)

        self.LogoFrame.Position = {
            self.ContentBg.Position.x + 10, 
            self.TabAnueButton.Background.Position.y + self.TabAnueButton.Background.Size.y + 10
        }

        if self.LogoImage then
            self.LogoImage.Position = {
                self.LogoFrame.Position.x + self.LogoFrame.Size.x / 2 - 15,
                self.LogoFrame.Position.y
            }
        end

        self.LogoText.Position = {
            self.LogoFrame.Position.x + self.LogoFrame.Size.x / 2,
            self.LogoFrame.Position.y + self.LogoFrame.Size.y / 2 - 8
        }
    end

    if self.ContentFrame and self.PageIndicator then
        self.PageIndicator.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2,  
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 20
        }

        if self.PrevPageButton and self.PrevPageButton.Background then
            self.PrevPageButton.Background.Position = {
                self.ContentFrame.Position.x + 10,
                self.ContentFrame.Position.y + self.ContentFrame.Size.y - 35
            }
            self:UpdateButtonTextPosition(self.PrevPageButton)
        end

        if self.NextPageButton and self.NextPageButton.Background then
            self.NextPageButton.Background.Position = {
                self.ContentFrame.Position.x + self.ContentFrame.Size.x - 90,
                self.ContentFrame.Position.y + self.ContentFrame.Size.y - 35
            }
            self:UpdateButtonTextPosition(self.NextPageButton)
        end
    end

    self:UpdateControlButtonsPosition()

    self:UpdateCornerPositions()
    self:UpdateScriptPositions()

    if self.TitleBarAccent then
        self.TitleBarAccent.Position = {
            self.TitleBar.Position.x,
            self.TitleBar.Position.y + self.TitleBar.Size.y
        }
        self.TitleBarAccent.Size = {self.TitleBar.Size.x, 2}
    end

    if self.ContentFrameBorder then
        self.ContentFrameBorder.Position = {self.ContentFrame.Position.x, self.ContentFrame.Position.y}
        self.ContentFrameBorder.Size = {self.ContentFrame.Size.x, self.ContentFrame.Size.y}
    end

    if IsExpanded then

        if self.TabIndicator and self.TabAnueButton and self.TabAnueButton.Background and 
           self.TabCommunityButton and self.TabCommunityButton.Background then
            pcall(function() 
                self.TabIndicator.Position = {
                    selected_tab == 1 and self.TabAnueButton.Background.Position.x or self.TabCommunityButton.Background.Position.x,
                    self.TabAnueButton.Background.Position.y + self.TabAnueButton.Background.Size.y
                }
                self.TabIndicator.Visible = true
            end)
        end

        if self.LogoBorder then
            self.LogoBorder.Position = {self.LogoFrame.Position.x, self.LogoFrame.Position.y}
            self.LogoBorder.Size = {self.LogoFrame.Size.x, self.LogoFrame.Size.y}
        end
    end

    if self.EnterButton and self.EnterButton.Background then
        self.EnterButton.Background.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x / 2 - 50,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 80
        }

        self:UpdateButtonTextPosition(self.EnterButton)
        end
    end

function AnueHub:SelectTab(tab)
    selected_tab = tab
    selected_index = 1
    current_page = 1

    if self.TabAnueButton and self.TabAnueButton.Background and
       self.TabCommunityButton and self.TabCommunityButton.Background then

        pcall(function()
            self.TabAnueButton.Background.Color = selected_tab == 1 and Colors.TabActive or Colors.TabInactive
            self.TabAnueButton.Border.Color = selected_tab == 1 and Colors.Highlight or Colors.Border
        end)

        pcall(function()
            self.TabCommunityButton.Background.Color = selected_tab == 2 and Colors.TabActive or Colors.TabInactive
            self.TabCommunityButton.Border.Color = selected_tab == 2 and Colors.Highlight or Colors.Border
        end)

        if self.TabIndicator then
            local targetX = selected_tab == 1 and 
                            self.TabAnueButton.Background.Position.x or 
                            self.TabCommunityButton.Background.Position.x
            local startX = self.TabIndicator.Position.x
            local startTime = time()
            local duration = 0.2

            spawn(function()
                local elapsed = 0
                while elapsed < duration and ui_running do
                    elapsed = time() - startTime
                    local progress = math.min(elapsed / duration, 1)
                    local eased_progress = progress * (2 - progress)
                    local currentX = startX + (targetX - startX) * eased_progress
                    self.TabIndicator.Position = {currentX, self.TabIndicator.Position.y}

                    local targetWidth = selected_tab == 1 and 120 or 150
                    local startWidth = self.TabIndicator.Size.x
                    local currentWidth = startWidth + (targetWidth - startWidth) * eased_progress
                    self.TabIndicator.Size = {currentWidth, self.TabIndicator.Size.y}

                    wait(0.016)
                end

                self.TabIndicator.Position = {targetX, self.TabIndicator.Position.y}
                self.TabIndicator.Size = {selected_tab == 1 and 120 or 150, self.TabIndicator.Size.y}
            end)
        end
    end

    self:UpdateVisibility()
    self:UpdateScriptPositions()
end

function AnueHub:UpdateScriptPositions(durante_arrasto)

    if not IsExpanded then return end

    local start_y = self.LogoFrame.Position.y + self.LogoFrame.Size.y + 15
    local option_spacing = 55  
    local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
    local start_index = (current_page - 1) * max_items_per_page + 1
    local end_index = math.min(start_index + max_items_per_page - 1, #active_scripts)
        local offset = selected_tab == 1 and 0 or #anue_scripts

        for i = start_index, end_index do
            local element_index = offset + i
            local display_index = (i - start_index) + 1

        if self.ScriptOptions[element_index] then
            self.ScriptOptions[element_index].Position = {
                self.ContentFrame.Position.x + 25,
                start_y + (display_index - 1) * option_spacing
            }

            if self.AuthorLabels[element_index] then
                self.AuthorLabels[element_index].Position = {
                    self.ContentFrame.Position.x + 30,
                    start_y + (display_index - 1) * option_spacing + 20 
                }
            end

            local script_data = active_scripts[i]
            if script_data and script_data.ExecuteButton then
                script_data.ExecuteButton.Background.Position = {
                    self.ContentFrame.Position.x + self.ContentFrame.Size.x - 120, 
                    start_y + (display_index - 1) * option_spacing
                }

                script_data.ExecuteButton.Background.Color = {90, 90, 210} 
                script_data.ExecuteButton.DefaultColor = {90, 90, 210}
                script_data.ExecuteButton.HoverColor = {110, 110, 255}
                script_data.ExecuteButton.PressColor = {70, 70, 180}
                script_data.ExecuteButton.BorderColor = {100, 100, 230}
                script_data.ExecuteButton.BorderHoverColor = {130, 130, 255}

                if script_data.ExecuteButton.Border then
                    script_data.ExecuteButton.Border.Color = {100, 100, 230}
                end

                self:UpdateButtonTextPosition(script_data.ExecuteButton)
                script_data.ExecuteButton.Background.Visible = true
                script_data.ExecuteButton.Text.Visible = true
                script_data.ExecuteButton.Border.Visible = true
                end
            end
        end

    if durante_arrasto or IsHovering then
        return
    end

    local start_y = self.LogoFrame.Position.y + self.LogoFrame.Size.y + 15
    local target_y = start_y + (selected_index - 1) * option_spacing - 8 

    self.SelectionHighlight.Size = {self.ContentFrame.Size.x - 20, 45}

    self.SelectionHighlight.Position = {
        self.ContentFrame.Position.x + 10,
        target_y
    }
end

function AnueHub:UpdateVisibility()

    self.WelcomeText.Visible = not IsExpanded and self.MainFrame.Visible

    if self.WelcomeVersionText then
        self.WelcomeVersionText.Visible = not IsExpanded and self.MainFrame.Visible
    end

    if self.WelcomeDecorTop then
        self.WelcomeDecorTop.Visible = not IsExpanded and self.MainFrame.Visible
    end

    if self.WelcomeDecorBottom then
        self.WelcomeDecorBottom.Visible = not IsExpanded and self.MainFrame.Visible
   end

    if self.WelcomeLogo then
        self.WelcomeLogo.Visible = not IsExpanded and self.MainFrame.Visible
    end

    self.TitleText.Visible = self.MainFrame.Visible
    if self.TitleGlow then
        self.TitleGlow.Visible = self.MainFrame.Visible
    end

    if self.TitleLogo then
        self.TitleLogo.Visible = self.MainFrame.Visible
    end

    if self.VersionText then
        self.VersionText.Visible = self.MainFrame.Visible
    end

    if self.TabAnueButton and self.TabCommunityButton then
        self.TabAnueButton.Background.Visible = IsExpanded and self.MainFrame.Visible
        self.TabAnueButton.Text.Visible = IsExpanded and self.MainFrame.Visible
        self.TabAnueButton.Border.Visible = IsExpanded and self.MainFrame.Visible

        self.TabCommunityButton.Background.Visible = IsExpanded and self.MainFrame.Visible
        self.TabCommunityButton.Text.Visible = IsExpanded and self.MainFrame.Visible
        self.TabCommunityButton.Border.Visible = IsExpanded and self.MainFrame.Visible
    end

    self.LogoFrame.Visible = IsExpanded and self.MainFrame.Visible
    self.LogoBorder.Visible = IsExpanded and self.MainFrame.Visible

    if self.LogoImage then
        self.LogoImage.Visible = false
    end

    self.LogoText.Visible = IsExpanded and self.MainFrame.Visible

    self.PageIndicator.Visible = IsExpanded and self.MainFrame.Visible
    self.SelectionHighlight.Visible = IsExpanded and self.MainFrame.Visible
    self.TabIndicator.Visible = IsExpanded and self.MainFrame.Visible

    local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
    local total_pages = math.ceil(#active_scripts / max_items_per_page)
    self.PageIndicator.Text = "Page " .. current_page .. "/" .. total_pages
    self.PageIndicator.Center = true  

    local start_index = (current_page - 1) * max_items_per_page + 1
    local end_index = math.min(start_index + max_items_per_page - 1, #active_scripts)
    local offset = selected_tab == 1 and 0 or #anue_scripts

    for i = 1, #self.ScriptOptions do
        self.ScriptOptions[i].Visible = false
        self.AuthorLabels[i].Visible = false
   end

    for _, script in ipairs(anue_scripts) do
        if script.ExecuteButton then
            script.ExecuteButton.Background.Visible = false
            script.ExecuteButton.Text.Visible = false
            script.ExecuteButton.Border.Visible = false
        end
    end

    for _, script in ipairs(community_scripts) do
        if script.ExecuteButton then
            script.ExecuteButton.Background.Visible = false
            script.ExecuteButton.Text.Visible = false
            script.ExecuteButton.Border.Visible = false
        end
    end

    if IsExpanded and self.MainFrame.Visible then
        for i = start_index, end_index do
            local element_index = offset + i
            self.ScriptOptions[element_index].Visible = true
            self.AuthorLabels[element_index].Visible = true

            local script_data = active_scripts[i]
            if script_data and script_data.ExecuteButton then
                script_data.ExecuteButton.Background.Visible = true
                script_data.ExecuteButton.Text.Visible = true
                script_data.ExecuteButton.Border.Visible = true
            end

            local display_index = i - start_index + 1
            if display_index == selected_index then
                self.ScriptOptions[element_index].Color = Colors.Highlight
            else
                self.ScriptOptions[element_index].Color = Colors.Text
            end
        end
    end

    self.OpenCloseGuide.Text = self.MainFrame.Visible and "Press [HOME] to close hub" or "Press [HOME] to open hub"
    if self.OpenCloseGuideShadow then 
        self.OpenCloseGuideShadow.Text = self.OpenCloseGuide.Text
    end

    self.ExpandGuide.Visible = self.MainFrame.Visible and not IsExpanded
    if self.ExpandGuideShadow then
        self.ExpandGuideShadow.Visible = self.ExpandGuide.Visible
    end

    self.NavigationGuide.Visible = self.MainFrame.Visible and IsExpanded
    if self.NavigationGuideShadow then
        self.NavigationGuideShadow.Visible = self.NavigationGuide.Visible
    end

    if self.EnterButton then
        self.EnterButton.Background.Visible = not IsExpanded and self.MainFrame.Visible
        self.EnterButton.Text.Visible = not IsExpanded and self.MainFrame.Visible
        self.EnterButton.Border.Visible = not IsExpanded and self.MainFrame.Visible
    end

    if self.PrevPageButton and self.NextPageButton then
        local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
        local total_pages = math.ceil(#active_scripts / max_items_per_page)

        local show_page_buttons = IsExpanded and self.MainFrame.Visible and total_pages > 1

        self.PrevPageButton.Background.Visible = show_page_buttons
        self.PrevPageButton.Text.Visible = show_page_buttons
        self.PrevPageButton.Border.Visible = show_page_buttons

        self.NextPageButton.Background.Visible = show_page_buttons
        self.NextPageButton.Text.Visible = show_page_buttons
        self.NextPageButton.Border.Visible = show_page_buttons

        if show_page_buttons then

            if current_page == 1 then
                self.PrevPageButton.Background.Color = {30, 30, 45} 
                self.PrevPageButton.Text.Color = {150, 150, 150} 
            else
                self.PrevPageButton.Background.Color = {40, 40, 60}
                self.PrevPageButton.Text.Color = Colors.Text
                self.PrevPageButton.DefaultColor = {40, 40, 60}
            end

            if current_page == total_pages then
                self.NextPageButton.Background.Color = {30, 30, 45} 
                self.NextPageButton.Text.Color = {150, 150, 150} 
            else
                self.NextPageButton.Background.Color = {40, 40, 60}
                self.NextPageButton.Text.Color = Colors.Text
                self.NextPageButton.DefaultColor = {40, 40, 60}
            end
        end
    end
end

function AnueHub:ResetToNonExpandedState()
    IsExpanded = false
    selected_index = 1
    current_page = 1

    self.MainFrame.Size = {original_width, original_height}
    self.BorderFrame.Size = {original_width - 2.5, original_height - 2.5}
    self.InnerFrame.Size = {self.BorderFrame.Size.x - 3, self.BorderFrame.Size.y - 3}
    self.ContentBg.Size = {self.InnerFrame.Size.x - 3, self.InnerFrame.Size.y - 3}

    self.TitleBar.Size = {self.ContentBg.Size.x - 10, 20}
    self.ContentFrame.Size = {self.ContentBg.Size.x - 10, self.ContentBg.Size.y - 35}

    if self.LogoFrame then
        self.LogoFrame.Size = {self.ContentBg.Size.x - 20, 30}
    end

    if self.ContentFrame and self.PageIndicator then
        self.PageIndicator.Position = {
            self.ContentFrame.Position.x + self.ContentFrame.Size.x - 60,
            self.ContentFrame.Position.y + self.ContentFrame.Size.y - 20
        }
    end

    for _, element in pairs(UIElements) do
        if element == self.MainFrame or 
           element == self.BorderFrame or 
           element == self.InnerFrame or 
           element == self.ContentBg or 
           element == self.TitleBar or 
           element == self.ContentFrame then

            element.Visible = self.MainFrame.Visible
        else

            if element == self.LogoFrame or 
               element == self.SelectionHighlight then
                element.Visible = false
            end
        end
    end

    for _, text in pairs(TextElements) do
        if text == self.TitleText or 
           text == self.WelcomeText or
           text == self.WelcomeVersionText then

            text.Visible = self.MainFrame.Visible
        elseif text == self.LogoText or 
               text == self.PageIndicator then

            text.Visible = false
        end
    end

    for i = 1, #self.ScriptOptions do
        self.ScriptOptions[i].Visible = false
        self.AuthorLabels[i].Visible = false
    end

    for _, script in ipairs(anue_scripts) do
        if script.ExecuteButton then
            script.ExecuteButton.Background.Visible = false
            script.ExecuteButton.Text.Visible = false
            script.ExecuteButton.Border.Visible = false
        end
    end

    for _, script in ipairs(community_scripts) do
        if script.ExecuteButton then
            script.ExecuteButton.Background.Visible = false
            script.ExecuteButton.Text.Visible = false
            script.ExecuteButton.Border.Visible = false
        end
    end

    if self.LogoBorder then
        self.LogoBorder.Visible = false
    end

    if self.TabIndicator then
        self.TabIndicator.Visible = false
    end

    self:UpdateLayout()
    self:UpdateVisibility()

    if self.PrevPageButton then
        self.PrevPageButton.Background.Visible = false
        self.PrevPageButton.Text.Visible = false
        self.PrevPageButton.Border.Visible = false
    end

    if self.NextPageButton then
        self.NextPageButton.Background.Visible = false
        self.NextPageButton.Text.Visible = false
        self.NextPageButton.Border.Visible = false
            end
        end

function AnueHub:ToggleUI()
    local wasVisible = IsVisible
    IsVisible = not IsVisible

    if FloatingLogo then FloatingLogo.Visible = not IsVisible end
    if FloatingLogoBg then FloatingLogoBg.Visible = not IsVisible end
    if FloatingLogoBorder then FloatingLogoBorder.Visible = not IsVisible end

    if IsVisible then

        local targetSize = {original_width, original_height}
        if IsExpanded then
            targetSize = {expanded_width, expanded_height}
        end

        self.MainFrame.Size = {targetSize[1] * 0.9, targetSize[2] * 0.9}
        self.MainFrame.Visible = true
        self.MainFrame.Transparency = 0

        spawn(function()
            local duration = 0.4
            local startTime = time()
            local elapsed = 0

            while elapsed < duration and ui_running do
                elapsed = time() - startTime
                local progress = math.min(elapsed / duration, 1)

                local scale
                if progress < 0.7 then
                    scale = 0.9 + (1.05 - 0.9) * (progress / 0.7)
                else
                    local p = (progress - 0.7) / 0.3
                    scale = 1.05 - (1.05 - 1.0) * p
                end

                local fadeProgress = math.min(progress * 2, 1)

                self.MainFrame.Size = {targetSize[1] * scale, targetSize[2] * scale}
                self.MainFrame.Transparency = ui_transparency * fadeProgress
                self:UpdateLayout()

                wait(0.016)
            end

            self.MainFrame.Size = targetSize
            self.MainFrame.Transparency = ui_transparency
            self:UpdateLayout()
        end)

        for _, element in pairs(UIElements) do

            if element ~= FloatingLogo and element ~= FloatingLogoBg and element ~= FloatingLogoBorder then
            element.Visible = true
            if element.Transparency ~= nil then
                    local originalTrans = element.Transparency
                    element.Transparency = 0
                    self:AnimateTransparency(element, 0, originalTrans, 0.3)
                end
            end
        end

        for _, text in pairs(TextElements) do 
            if not table.find(self.GuideTexts, text) then
                text.Visible = true
            if text.Transparency ~= nil then
                    local originalTrans = text.Transparency
                    text.Transparency = 0
                    self:AnimateTransparency(text, 0, originalTrans, 0.3)
            end
            end
        end

        if self.TitleText then
            self.TitleText.Visible = true

        end

        if self.TitleLogo then
            self.TitleLogo.Visible = true
            self.TitleLogo.Size = {25, 25} 
            self.TitleLogo.Transparency = 0

            spawn(function()
                local duration = 0.4
                local startTime = time()
                local elapsed = 0

                while elapsed < duration and ui_running do
                    elapsed = time() - startTime
                    local progress = math.min(elapsed / duration, 1)
                    local eased_progress = progress * (2 - progress) 

                    local current_scale = 25 - (25 - 20) * eased_progress
                    self.TitleLogo.Size = {current_scale, current_scale}

                    self.TitleLogo.Transparency = progress

                    wait(0.016)
                end

                self.TitleLogo.Size = {20, 20}
                self.TitleLogo.Transparency = 1
            end)
        end

        if self.CloseButton then
            self.CloseButton.Background.Visible = true
            self.CloseButton.Text.Visible = true
            self.CloseButton.Border.Visible = true
        end

        if self.ExpandButton then
            self.ExpandButton.Background.Visible = true
            self.ExpandButton.Text.Visible = true
            self.ExpandButton.Border.Visible = true
        end

        self:UpdateVisibility()

        if not IsExpanded then

            if self.WelcomeDecorTop then
                local originalWidth = self.WelcomeDecorTop.Size.x
                self.WelcomeDecorTop.Size = {0, 3}

spawn(function()
                    local duration = 0.6
                    local startTime = time()

                    while time() - startTime < duration and ui_running do
                        local progress = (time() - startTime) / duration
                        local eased = progress * (2 - progress) 
                        self.WelcomeDecorTop.Size = {originalWidth * eased, 3}
                        wait(0.016)
                    end

                    self.WelcomeDecorTop.Size = {originalWidth, 3}
                end)
            end

            if self.WelcomeDecorBottom then
                local originalWidth = self.WelcomeDecorBottom.Size.x
                self.WelcomeDecorBottom.Size = {0, 3}

spawn(function()
                    local duration = 0.6
                    local startTime = time()

                    while time() - startTime < duration and ui_running do
                        local progress = (time() - startTime) / duration
                        local eased = progress * (2 - progress) 
                        self.WelcomeDecorBottom.Size = {originalWidth * eased, 3}
                        wait(0.016)
                    end

                    self.WelcomeDecorBottom.Size = {originalWidth, 3}
                end)
            end

            if self.WelcomeLogo then
                self.WelcomeLogo.Transparency = 0

spawn(function()
                    local duration = 0.8
                    local startTime = time()

                    while time() - startTime < duration and ui_running do
                        local progress = (time() - startTime) / duration
                        local transparency = progress

                        self.WelcomeLogo.Transparency = transparency

                        wait(0.016)
                    end

                    self.WelcomeLogo.Transparency = 1
                end)
            end

            if self.EnterButton and self.EnterButton.Background then
                local originalY = self.EnterButton.Background.Position.y
                self.EnterButton.Background.Position = {
                    self.EnterButton.Background.Position.x,
                    originalY + 20
                }
                self:UpdateButtonTextPosition(self.EnterButton)

spawn(function()
                    local duration = 0.5
                    local startTime = time()

                    while time() - startTime < duration and ui_running do
                        local progress = (time() - startTime) / duration
                        local eased_progress = progress * (2 - progress) 
                        local currentY = originalY + 20 * (1 - eased_progress)

                        self.EnterButton.Background.Position = {
                            self.EnterButton.Background.Position.x,
                            currentY
                        }
                        self:UpdateButtonTextPosition(self.EnterButton)

                        wait(0.016)
                    end

                    self.EnterButton.Background.Position = {
                        self.EnterButton.Background.Position.x,
                        originalY
                    }
                    self:UpdateButtonTextPosition(self.EnterButton)
                end)
            end
        end
    else

        if FloatingLogo and FloatingLogoBg then

            FloatingLogoBg.Position = {SCREEN_DIMENSIONS.x / 2, 100}
            FloatingLogo.Position = {SCREEN_DIMENSIONS.x / 2 - 17.5, 100 - 17.5}
            FloatingLogoBg.Visible = true
            FloatingLogo.Visible = true
            if FloatingLogoBorder then
                FloatingLogoBorder.Position = {SCREEN_DIMENSIONS.x / 2, 100}
                FloatingLogoBorder.Visible = true
            end

            local startScale = 0
            local endScale = 25 
            local startTime = time()
            local duration = 0.4

spawn(function()
                while time() - startTime < duration and ui_running and not IsVisible do
                    local progress = (time() - startTime) / duration
                    local eased = progress * (2 - progress) 
                    local currentScale = startScale + (endScale - startScale) * eased

                    FloatingLogoBg.Radius = currentScale
                    if FloatingLogoBorder then
                        FloatingLogoBorder.Radius = currentScale
                        FloatingLogoBorder.Transparency = eased * 0.9
                    end
                    if FloatingLogoBg.Radius ~= nil then
                        FloatingLogoBg.Transparency = eased * 0.85
                    end

                    local newSize = currentScale * 1.4
                    FloatingLogo.Size = {newSize, newSize}
                    FloatingLogo.Position = {
                        SCREEN_DIMENSIONS.x / 2 - newSize / 2, 
                        100 - newSize / 2
                    }
                    FloatingLogo.Transparency = eased

                    wait(0.016)
                end

                if not IsVisible then
                    FloatingLogoBg.Radius = endScale
                    FloatingLogoBg.Transparency = 0.85
                    if FloatingLogoBorder then
                        FloatingLogoBorder.Radius = endScale
                        FloatingLogoBorder.Transparency = 0.9
                    end
                    FloatingLogo.Size = {35, 35}
                    FloatingLogo.Position = {SCREEN_DIMENSIONS.x / 2 - 17.5, 100 - 17.5}
                    FloatingLogo.Transparency = 1
    end
end)
        end

        local fadeOutDuration = 0.4
        local startTime = time()
        local originalTransparencies = {}
        local originalSize = {self.MainFrame.Size.x, self.MainFrame.Size.y}

        for _, button in pairs(ButtonElements) do

                pcall(function()
                button.Background.Visible = false
                button.Text.Visible = false
                button.Border.Visible = false
                end)
            end

        for _, script in ipairs(anue_scripts) do
            if script.ExecuteButton then
                pcall(function()
                    script.ExecuteButton.Background.Visible = false
                    script.ExecuteButton.Text.Visible = false
                    script.ExecuteButton.Border.Visible = false
                end)
            end
        end

        for _, script in ipairs(community_scripts) do
            if script.ExecuteButton then
                pcall(function()
                    script.ExecuteButton.Background.Visible = false
                    script.ExecuteButton.Text.Visible = false
                    script.ExecuteButton.Border.Visible = false
                end)
            end
        end

        for _, element in pairs(UIElements) do
            if element.Transparency ~= nil and element ~= FloatingLogo and element ~= FloatingLogoBg and element ~= FloatingLogoBorder then
                originalTransparencies[element] = element.Transparency
            end
        end

        for _, text in pairs(TextElements) do 
            if not table.find(self.GuideTexts, text) and text.Transparency ~= nil then
                originalTransparencies[text] = text.Transparency
            end
        end

spawn(function()
            local elapsed = 0

            while elapsed < fadeOutDuration and ui_running do
                elapsed = time() - startTime
                local progress = math.min(elapsed / fadeOutDuration, 1)
                local fadeAmount = 1 - progress
                local scaleAmount = 1 - (progress * 0.1) 

                for element, originalTransparency in pairs(originalTransparencies) do
                    if element.Transparency ~= nil then
                        element.Transparency = originalTransparency * fadeAmount
                    end
                end

                self.MainFrame.Size = {
                    originalSize[1] * scaleAmount,
                    originalSize[2] * scaleAmount
                }
                self:UpdateLayout()

                wait(0.016)
            end

        for _, element in pairs(UIElements) do

                if element ~= FloatingLogo and element ~= FloatingLogoBg and element ~= FloatingLogoBorder then
            element.Visible = false
                end
        end

        for _, text in pairs(TextElements) do 
                if not table.find(self.GuideTexts, text) then
                text.Visible = false
            end
        end

            for element, originalTransparency in pairs(originalTransparencies) do
                if element.Transparency ~= nil then
                    element.Transparency = originalTransparency
                end
            end

            self:ResetToNonExpandedState()
                end)
            end

    self.OpenCloseGuide.Text = IsVisible and "Press [HOME] to close hub" or "Press [HOME] to open hub"
    if self.OpenCloseGuideShadow then 
        self.OpenCloseGuideShadow.Text = self.OpenCloseGuide.Text
    end

    self.ExpandGuide.Visible = self.MainFrame.Visible and not IsExpanded
    if self.ExpandGuideShadow then
        self.ExpandGuideShadow.Visible = self.ExpandGuide.Visible
    end

    self.NavigationGuide.Visible = self.MainFrame.Visible and IsExpanded
    if self.NavigationGuideShadow then
        self.NavigationGuideShadow.Visible = self.NavigationGuide.Visible
    end
end

function AnueHub:ToggleExpanded()
    IsExpanded = not IsExpanded

    if self._expandButtonText then

                pcall(function()
            self._expandButtonText.Text = IsExpanded and "-" or "+"
        end)
    elseif self.ExpandButton and self.ExpandButton.Text then

                pcall(function()
            self.ExpandButton.Text.Text = IsExpanded and "-" or "+"
                end)
            end

    self:AnimateResize(IsExpanded)
end

function AnueHub:ExecuteScript(script_data)

    if ExecutionCooldown then

        self:ShowCooldownNotification()
        return
    end

    self:ShowConfirmationDialog(script_data)
end

function AnueHub:ShowConfirmationDialog(script_data)
    if ConfirmationDialogActive then return end
    ConfirmationDialogActive = true
    ScriptToExecute = script_data

    for _, element in ipairs(ConfirmationDialogElements) do
        pcall(function() 
            if element then 
                element.Visible = false
                element:Remove() 
    end
end)
    end

    ConfirmationDialogElements = {}

    local overlay = Drawing.new("Square")
    overlay.Filled = true
    overlay.Visible = true
    overlay.Size = {SCREEN_DIMENSIONS.x, SCREEN_DIMENSIONS.y}
    overlay.Position = {0, 0}
    overlay.Color = {10, 10, 15}
    overlay.Transparency = 0.7
    table.insert(ConfirmationDialogElements, overlay)
    self.ConfirmOverlay = overlay

    local window = Drawing.new("Square")
    window.Filled = true
    window.Visible = true
    window.Size = {400, 200}
    window.Position = {
        SCREEN_DIMENSIONS.x / 2 - 200,
        SCREEN_DIMENSIONS.y / 2 - 100
    }
    window.Color = Colors.Background
    window.Transparency = 0.95
    table.insert(ConfirmationDialogElements, window)
    self.ConfirmWindow = window

    local border = Drawing.new("Square")
    border.Filled = false
    border.Visible = true
    border.Size = {400, 200}
    border.Position = {
        SCREEN_DIMENSIONS.x / 2 - 200,
        SCREEN_DIMENSIONS.y / 2 - 100
    }
    border.Color = Colors.Border
    self:SafeSetThickness(border, 2)
    border.Transparency = 0.95
    table.insert(ConfirmationDialogElements, border)
    self.ConfirmBorder = border

    local title = Drawing.new("Text")
    title.Text = "Confirm Execution"
    title.Visible = true
    title.Center = true
    title.Color = Colors.Highlight
    title.Size = text_size + 2
    title.Font = font 
    title.Transparency = text_transparency
    title.Position = {
        SCREEN_DIMENSIONS.x / 2,
        SCREEN_DIMENSIONS.y / 2 - 85
    }
    title.Outline = true
    table.insert(ConfirmationDialogElements, title)
    self.ConfirmTitle = title

    local message = Drawing.new("Text")
    message.Text = "Are you sure you want to execute\n\"" .. script_data.name .. "\"?"
    message.Visible = true
    message.Center = true
    message.Color = Colors.Text
    message.Size = text_size
    message.Font = font 
    message.Transparency = text_transparency
    message.Position = {
        SCREEN_DIMENSIONS.x / 2,
        SCREEN_DIMENSIONS.y / 2 - 40
    }
    table.insert(ConfirmationDialogElements, message)
    self.ConfirmMessage = message

    local author = Drawing.new("Text")
    author.Text = "by: " .. script_data.author
    author.Visible = true
    author.Center = true
    author.Color = {180, 180, 255}
    author.Size = text_size - 2
    author.Font = font 
    author.Transparency = text_transparency
    author.Position = {
        SCREEN_DIMENSIONS.x / 2,
        SCREEN_DIMENSIONS.y / 2 - 10
    }
    table.insert(ConfirmationDialogElements, author)
    self.ConfirmAuthor = author

    self.ConfirmYesButton = self:CreateButton({
        position = {
            SCREEN_DIMENSIONS.x / 2 - 110,
            SCREEN_DIMENSIONS.y / 2 + 30
        },
        size = {100, 35},
        text = "Yes",
        textSize = 16,
        font = font, 
        color = {70, 120, 70}, 
        hoverColor = {90, 160, 90},
        pressColor = {50, 100, 50},
        borderColor = {100, 170, 100},
        borderHoverColor = {120, 200, 120},
        visible = true,
        callback = function()
            self:CloseConfirmationDialog()
            self:ActuallyExecuteScript(script_data)
        end
    })

    if self.ConfirmYesButton then
        if self.ConfirmYesButton.Background then table.insert(ConfirmationDialogElements, self.ConfirmYesButton.Background) end
        if self.ConfirmYesButton.Text then table.insert(ConfirmationDialogElements, self.ConfirmYesButton.Text) end
        if self.ConfirmYesButton.Border then table.insert(ConfirmationDialogElements, self.ConfirmYesButton.Border) end
    end

    self.ConfirmNoButton = self:CreateButton({
        position = {
            SCREEN_DIMENSIONS.x / 2 + 10,
            SCREEN_DIMENSIONS.y / 2 + 30
        },
        size = {100, 35},
        text = "No",
        textSize = 16,
        font = font, 
        color = {120, 70, 70}, 
        hoverColor = {160, 90, 90},
        pressColor = {100, 50, 50},
        borderColor = {170, 100, 100},
        borderHoverColor = {200, 120, 120},
        visible = true,
        callback = function()
            self:CloseConfirmationDialog()
        end
    })

    if self.ConfirmNoButton then
        if self.ConfirmNoButton.Background then table.insert(ConfirmationDialogElements, self.ConfirmNoButton.Background) end
        if self.ConfirmNoButton.Text then table.insert(ConfirmationDialogElements, self.ConfirmNoButton.Text) end
        if self.ConfirmNoButton.Border then table.insert(ConfirmationDialogElements, self.ConfirmNoButton.Border) end
    end
end

function AnueHub:CloseConfirmationDialog()

    ConfirmationDialogActive = false
    ScriptToExecute = nil

    local elementsToRemove = {}
    for _, element in ipairs(ConfirmationDialogElements) do
        if element then
            table.insert(elementsToRemove, element)
        end
    end

    for _, element in ipairs(elementsToRemove) do
        if element then

            pcall(function() element.Visible = false end)
        end
    end

    wait(0.05)

    for _, element in ipairs(elementsToRemove) do
        if element then
            pcall(function() element:Remove() end)
        end
    end

    self.ConfirmOverlay = nil
    self.ConfirmWindow = nil
    self.ConfirmBorder = nil
    self.ConfirmTitle = nil
    self.ConfirmMessage = nil
    self.ConfirmAuthor = nil

    if self.ConfirmYesButton then
        self.ConfirmYesButton.Background = nil
        self.ConfirmYesButton.Text = nil
        self.ConfirmYesButton.Border = nil
        self.ConfirmYesButton = nil
    end

    if self.ConfirmNoButton then
        self.ConfirmNoButton.Background = nil
        self.ConfirmNoButton.Text = nil
        self.ConfirmNoButton.Border = nil
        self.ConfirmNoButton = nil
    end

    ConfirmationDialogElements = {}
end

function AnueHub:ActuallyExecuteScript(script_data)

    SET_SCHEDULER_TIMEOUT(false)

    local script_code = script_data.loadstring

    local countdownElements = {}

    local countdown_overlay = Drawing.new("Square")
    countdown_overlay.Filled = true
    countdown_overlay.Visible = true
    countdown_overlay.Size = {SCREEN_DIMENSIONS.x, SCREEN_DIMENSIONS.y}
    countdown_overlay.Position = {0, 0}
    countdown_overlay.Color = {10, 10, 15}
    countdown_overlay.Transparency = 0.7
    table.insert(countdownElements, countdown_overlay)

    local countdown_bg = Drawing.new("Square")
    countdown_bg.Filled = true
    countdown_bg.Visible = true
    countdown_bg.Size = {400, 180}
    countdown_bg.Position = {
        SCREEN_DIMENSIONS.x / 2 - 200,
        SCREEN_DIMENSIONS.y / 2 - 90
    }
    countdown_bg.Color = Colors.Background
    countdown_bg.Transparency = 0.95
    table.insert(countdownElements, countdown_bg)

    local countdown_text = Drawing.new("Text")
    countdown_text.Text = "5"
    countdown_text.Visible = true
    countdown_text.Center = true
    countdown_text.Color = Colors.Accent
    countdown_text.Size = text_size + 8
    countdown_text.Font = font
    countdown_text.Position = {
        SCREEN_DIMENSIONS.x / 2,
        countdown_bg.Position.y + 60
    }
    countdown_text.Outline = true
    table.insert(countdownElements, countdown_text)

    local progress_bg = Drawing.new("Square")
    progress_bg.Filled = true
    progress_bg.Visible = true
    progress_bg.Size = {300, 10}
    progress_bg.Position = {
        SCREEN_DIMENSIONS.x / 2 - 150,
        countdown_text.Position.y + 40
    }
    progress_bg.Color = Colors.InnerBg2
    progress_bg.Transparency = 0.9
    table.insert(countdownElements, progress_bg)

    local progress_fill = Drawing.new("Square")
    progress_fill.Filled = true
    progress_fill.Visible = true
    progress_fill.Size = {0, 10}
    progress_fill.Position = {
        SCREEN_DIMENSIONS.x / 2 - 150,
        countdown_text.Position.y + 40
    }
    progress_fill.Color = Colors.Accent
    progress_fill.Transparency = 0.9
    table.insert(countdownElements, progress_fill)

    for i = 5, 1, -1 do
        countdown_text.Text = tostring(i)
        progress_fill.Size = {300 * ((5 - i) / 5), 10}
        wait(1)
    end

    countdown_text.Text = "Cleaning..."
    progress_fill.Size = {300, 10}
    progress_fill.Color = {50, 200, 50}

    ui_running = false
    IsVisible = false
    IsExpanded = false
        IsDragging = false
        IsHovering = false
    MouseHeld = false

    UIElements = {}
    TextElements = {}
    ButtonElements = {}
    countdownElements = {}

    self.MainFrame = nil
    self.ContentFrame = nil
    self.LogoFrame = nil
    setmetatable(self, nil)

    Drawing.clear()

    wait(0.1)

    SET_SCHEDULER_TIMEOUT(true)

    loadstring(script_code)()

    spawn(function()
        wait(5)
        ExecutionCooldown = false
    end)
end

function AnueHub:ShowCooldownNotification()

    local notificationElements = {}

    local notification_overlay = Drawing.new("Square")
    notification_overlay.Filled = true
    notification_overlay.Visible = true
    notification_overlay.Size = {SCREEN_DIMENSIONS.x, SCREEN_DIMENSIONS.y}
    notification_overlay.Position = {0, 0}
    notification_overlay.Color = {10, 10, 15}
    notification_overlay.Transparency = 0.5
    table.insert(notificationElements, notification_overlay)

    local notification_bg = Drawing.new("Square")
    notification_bg.Filled = true
    notification_bg.Visible = true
    notification_bg.Size = {400, 120}
    notification_bg.Position = {
        SCREEN_DIMENSIONS.x / 2 - 200,
        SCREEN_DIMENSIONS.y / 2 - 60
    }
    notification_bg.Color = Colors.Background
    notification_bg.Transparency = 0.95
    table.insert(notificationElements, notification_bg)

    local notification_border = Drawing.new("Square")
    notification_border.Filled = false
    notification_border.Visible = true
    notification_border.Size = notification_bg.Size
    notification_border.Position = notification_bg.Position
    notification_border.Color = Colors.Border
    self:SafeSetThickness(notification_border, 2)
    notification_border.Transparency = 0.95
    table.insert(notificationElements, notification_border)

    local title_text = Drawing.new("Text")
    title_text.Text = "Cooldown Notice"
    title_text.Visible = true
    title_text.Center = true
    title_text.Color = Colors.Highlight
    title_text.Size = text_size + 2
    title_text.Font = font 
    title_text.Transparency = text_transparency
    title_text.Position = {
        SCREEN_DIMENSIONS.x / 2,
        notification_bg.Position.y + 20
    }
    title_text.Outline = true
    table.insert(notificationElements, title_text)

    local notification_text = Drawing.new("Text")
    notification_text.Text = "Please wait 5 seconds to execute another script"
    notification_text.Visible = true
    notification_text.Center = true
    notification_text.Color = Colors.TextSecondary
    notification_text.Size = text_size
    notification_text.Font = font 
    notification_text.Position = {
        SCREEN_DIMENSIONS.x / 2,
        notification_bg.Position.y + 60
    }
    notification_text.Outline = true
    table.insert(notificationElements, notification_text)

    local icon = Drawing.new("Circle")
    icon.Filled = false
    icon.Visible = true
    icon.Position = {
        SCREEN_DIMENSIONS.x / 2 - 130,
        notification_bg.Position.y + 60
    }
    icon.Radius = 10
    icon.NumSides = 20
    icon.Color = {200, 100, 100}
    self:SafeSetThickness(icon, 2)
    icon.Transparency = 0.9
    table.insert(notificationElements, icon)

    local threadActive = true

    spawn(function()
        local startTime = time()
        local duration = 2 

        for i = 1, 10 do
            if not threadActive or not ui_running then break end
            local alpha = i / 10
            for _, element in ipairs(notificationElements) do
                pcall(function() element.Transparency = element.Transparency * alpha end)
            end
            wait(0.01)
        end

        for i = 1, duration * 10 do
            if not threadActive or not ui_running then break end
            wait(0.1)
        end

        for i = 10, 1, -1 do
            if not threadActive or not ui_running then break end
            local alpha = i / 10
            for _, element in ipairs(notificationElements) do
                pcall(function() element.Transparency = element.Transparency * alpha end)
            end
            wait(0.01)
        end

        for _, element in ipairs(notificationElements) do
            pcall(function() 
                element.Visible = false
                element:Remove() 
            end)
        end

        table.clear(notificationElements)
        threadActive = false
    end)

    if not ui_running then
        threadActive = false
        for _, element in ipairs(notificationElements) do
            pcall(function() 
                element.Visible = false
                element:Remove() 
            end)
        end
        table.clear(notificationElements)
    end
end

function AnueHub:RegisterInputHandlers()

spawn(function()
    while ui_running do
            if self.MainFrame.Visible then
                local mouse_pos = getmouselocation(MouseService)

                local is_over_title = 
                    mouse_pos.x >= self.TitleBar.Position.x and 
                    mouse_pos.x <= self.TitleBar.Position.x + self.TitleBar.Size.x and
                    mouse_pos.y >= self.TitleBar.Position.y and
                    mouse_pos.y <= self.TitleBar.Position.y + self.TitleBar.Size.y

                if is_over_title and isleftpressed() and not IsDragging then
                    IsDragging = true
                    DragOffset.x = mouse_pos.x - self.MainFrame.Position.x
                    DragOffset.y = mouse_pos.y - self.MainFrame.Position.y
                end

                if IsDragging then
                    if isleftpressed() then
                        self.MainFrame.Position = {
                            mouse_pos.x - DragOffset.x,
                            mouse_pos.y - DragOffset.y
                        }
                        self:UpdateLayout()

                    else
                        IsDragging = false
                end
            end
            else
                IsDragging = false
        end

        wait(0.01)
    end
end)

spawn(function()
        local home_pressed = false
        local enter_pressed = false
        local f1_pressed = false
        local f2_pressed = false
        local arrow_pressed = false
        local y_pressed = false

    while ui_running do
                local pressed_keys = getpressedkeys()
            local current_home = false
            local current_enter = false
            local current_f1 = false
            local current_f2 = false
                local arrow_up = false
                local arrow_down = false
                local arrow_left = false
                local arrow_right = false
            local current_y = false

                for _, key in ipairs(pressed_keys) do
                    local key_name = key:lower()
                if key_name == "home" then current_home = true end
                if key_name == "enter" then current_enter = true end
                if key_name == "f1" then current_f1 = true end
                if key_name == "f2" then current_f2 = true end
                    if key_name == "uparrow" then arrow_up = true end
                    if key_name == "downarrow" then arrow_down = true end
                    if key_name == "leftarrow" then arrow_left = true end
                    if key_name == "rightarrow" then arrow_right = true end
                if key_name == "y" then current_y = true end
            end

            if current_home and not home_pressed then
                self:ToggleUI()
            end
            home_pressed = current_home

            if current_enter and not enter_pressed and self.MainFrame.Visible then
                self:ToggleExpanded()
            end
            enter_pressed = current_enter

            if current_f1 and not f1_pressed and selected_tab ~= 1 and IsExpanded then
                self:SelectTab(1)
            end
            f1_pressed = current_f1

            if current_f2 and not f2_pressed and selected_tab ~= 2 and IsExpanded then
                self:SelectTab(2)
            end
            f2_pressed = current_f2

            if self.MainFrame.Visible and IsExpanded and not arrow_pressed then
                        local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
                        local start_index = (current_page - 1) * max_items_per_page + 1
                        local end_index = math.min(start_index + max_items_per_page - 1, #active_scripts)
                        local items_in_current_page = end_index - start_index + 1

                        if arrow_up then 
                            selected_index = math.max(1, selected_index - 1) 
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                        end

                        if arrow_down then 
                            selected_index = math.min(items_in_current_page, selected_index + 1) 
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                end

                        local total_pages = math.ceil(#active_scripts / max_items_per_page)

                        if arrow_left and current_page > 1 then
                            current_page = current_page - 1
                            selected_index = 1
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                        end

                        if arrow_right and current_page < total_pages then
                            current_page = current_page + 1
                            selected_index = 1
                    self:UpdateVisibility()
                    self:UpdateScriptPositions()
                end
            end
            arrow_pressed = arrow_up or arrow_down or arrow_left or arrow_right

            if current_y and not y_pressed and self.MainFrame.Visible and IsExpanded then
                self:ExecuteSelectedScript()
            end
            y_pressed = current_y

            wait(0.05)
        end
    end)

    spawn(function()
        while ui_running do
            self:UpdateVisibility()

            self:CheckScriptOptionsHover()
            wait(0.05) 
        end
    end)
end

function AnueHub:Destroy()

    ui_running = false
    IsVisible = false
    IsExpanded = false

    Drawing.clear()

    UIElements = {}
    TextElements = {}
    ButtonElements = {}

    self.MainFrame = nil
    self.ContentFrame = nil
    self.LogoFrame = nil

    setmetatable(self, nil)
end

function table.find(t, value)
    if type(t) ~= "table" then return false end
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

function AnueHub:AddCommunityScripts(scripts)

    if not table.clear then
        table.clear = function(t)
            for k in pairs(t) do
                t[k] = nil
            end
        end
    end

    for _, script in ipairs(scripts) do
        table.insert(community_scripts, script)

        local i = #community_scripts
        local start_y = self.ContentFrame.Position.y + 40
        local option_spacing = 50  

        local text = Drawing.new("Text")
        text.Text = script.name
        text.Visible = false
        text.Color = Colors.Text
        text.Size = text_size
        text.Font = font
        text.Transparency = text_transparency
        text.Position = {
            self.ContentFrame.Position.x + 20,
            start_y + (i-1) % max_items_per_page * option_spacing
        }
        table.insert(self.ScriptOptions, text)
        table.insert(TextElements, text)

        local author_text = Drawing.new("Text")
        author_text.Text = "by " .. script.author
        author_text.Visible = false
        author_text.Color = {180, 180, 255}
        author_text.Size = text_size - 2
        author_text.Font = font
        author_text.Transparency = text_transparency
        author_text.Position = {
            self.ContentFrame.Position.x + 25,
            start_y + (i-1) % max_items_per_page * option_spacing + 20
        }
        table.insert(self.AuthorLabels, author_text)
        table.insert(TextElements, author_text)

        local execute_button = self:CreateButton({
            position = {
                self.ContentFrame.Position.x + self.ContentFrame.Size.x - 95,
                start_y + (i-1) % max_items_per_page * option_spacing + 5
            },
            size = {85, 25}, 
            text = "Execute",
            textSize = 12,
            color = {50, 80, 50},
            hoverColor = {70, 130, 70},
            pressColor = {40, 100, 40},
            borderColor = {70, 110, 70},
            borderHoverColor = {90, 190, 90},
            visible = false,
            callback = function()
                self:ExecuteScript(community_scripts[i])
            end
        })

        script.ExecuteButton = execute_button
    end

    self:UpdateVisibility()
    self:UpdateScriptPositions()
end

function AnueHub:CreateTitleHoverIndicator()
    self.TitleHoverIndicator = Drawing.new("Square")
    self.TitleHoverIndicator.Filled = true
    self.TitleHoverIndicator.Visible = false
    self.TitleHoverIndicator.Color = Colors.Highlight
    self.TitleHoverIndicator.Transparency = 0.3
    table.insert(UIElements, self.TitleHoverIndicator)

spawn(function()
    while ui_running do
            if self.MainFrame.Visible then
            local mouse_pos = getmouseposition()

            local is_over_title = 
                    mouse_pos.x >= self.TitleBar.Position.x and 
                    mouse_pos.x <= self.TitleBar.Position.x + self.TitleBar.Size.x and
                    mouse_pos.y >= self.TitleBar.Position.y and
                    mouse_pos.y <= self.TitleBar.Position.y + self.TitleBar.Size.y

                if is_over_title and not IsDragging then
                    self.TitleHoverIndicator.Visible = true
                    self.TitleHoverIndicator.Size = self.TitleBar.Size
                    self.TitleHoverIndicator.Position = self.TitleBar.Position

                    self.TitleBar.Color = {
                        Colors.TitleBg[1] + 10,
                        Colors.TitleBg[2] + 10,
                        Colors.TitleBg[3] + 10
                    }
                else
                    self.TitleHoverIndicator.Visible = false
                    self.TitleBar.Color = Colors.TitleBg
                end
            else
                self.TitleHoverIndicator.Visible = false
            end

            wait(0.01)
        end
    end)
end

function AnueHub:AnimateUI(element, property, start_value, end_value, duration, callback)
    local start_time = time()
    local range = {}

    if type(start_value) == "table" and type(end_value) == "table" then
        for i, v in pairs(start_value) do
            range[i] = end_value[i] - v
        end
    else
        range = end_value - start_value
    end

    spawn(function()
        local elapsed = 0
        local progress = 0

        while elapsed < duration and ui_running do
            elapsed = time() - start_time
            progress = math.min(elapsed / duration, 1)

            local eased_progress = progress * (2 - progress)

            if type(start_value) == "table" and type(end_value) == "table" then
                local current_value = {}
                for i, v in pairs(start_value) do
                    current_value[i] = v + range[i] * eased_progress
                end
                element[property] = current_value
            else
                element[property] = start_value + range * eased_progress
            end

            wait(0.016)
        end

        element[property] = end_value

        if callback then
            callback()
    end
end)
end

function AnueHub:CreateElementPropertiesTracker()
    self.ElementProperties = {}

    function self:GetElementProperty(element, property, default)
        if not element then return default end
        if not self.ElementProperties[element] then return default end
        if self.ElementProperties[element][property] == nil then return default end
        return self.ElementProperties[element][property]
    end

    function self:SetElementProperty(element, property, value)
        if not element then return end
        self.ElementProperties[element] = self.ElementProperties[element] or {}
        self.ElementProperties[element][property] = value
    end

spawn(function()
    while ui_running do
            wait(1)

            local keys_to_remove = {}
            for element, _ in pairs(self.ElementProperties) do
                if pcall(function() return element.Visible end) == false then
                    table.insert(keys_to_remove, element)
                end
            end

            for _, key in ipairs(keys_to_remove) do
                self.ElementProperties[key] = nil
            end
    end
end)
end

function AnueHub:AnimateResize(is_expanding)
    local target_width = is_expanding and expanded_width or original_width
    local target_height = is_expanding and expanded_height or original_height

    local start_width = self.MainFrame.Size.x
    local start_height = self.MainFrame.Size.y
    local duration = 0.3
    local start_time = time()

    spawn(function()
        local elapsed = 0
        local progress = 0

        while elapsed < duration and ui_running do
            elapsed = time() - start_time
            progress = math.min(elapsed / duration, 1)

            local eased_progress = progress * (2 - progress)

            local current_width = start_width + (target_width - start_width) * eased_progress
            local current_height = start_height + (target_height - start_height) * eased_progress

            self.MainFrame.Size = {current_width, current_height}

            self.BorderFrame.Size = {current_width - 2.5, current_height - 2.5}
            self.InnerFrame.Size = {self.BorderFrame.Size.x - 3, self.BorderFrame.Size.y - 3}
            self.ContentBg.Size = {self.InnerFrame.Size.x - 3, self.InnerFrame.Size.y - 3}
            self.TitleBar.Size = {self.ContentBg.Size.x - 10, 20}
            self.ContentFrame.Size = {self.ContentBg.Size.x - 10, self.ContentBg.Size.y - 35}

            if self.SelectionHighlight then
                self.SelectionHighlight.Size = {self.ContentFrame.Size.x - 20, 45}
            end

            self:UpdateCornerPositions()

            if self.LogoFrame then
                self.LogoFrame.Size = {self.ContentBg.Size.x - 20, 30}
                self.LogoFrame.Position = {self.ContentBg.Position.x + 10, self.ContentFrame.Position.y + 5}

                if self.LogoText then
                    self.LogoText.Position = {
                        self.LogoFrame.Position.x + self.LogoFrame.Size.x / 2,
                        self.LogoFrame.Position.y + self.LogoFrame.Size.y / 2 - 7
                    }
        end
    end

            self:UpdateLayout()

            wait(0.016) 
        end

        self.MainFrame.Size = {target_width, target_height}
        self:UpdateLayout()
        self:UpdateVisibility()
    end)
end

function AnueHub:Cleanup()

    for key, value in pairs(self) do
        if type(value) == "table" then

            for subkey, subvalue in pairs(value) do
                if subvalue == self or (type(subvalue) == "table" and subvalue[1] == self) then
                    value[subkey] = nil
                end
            end
        end
    end

    ui_running = false

    Mouse.Clicked = false
    Mouse.Pressed = false

    MouseHeld = false
    IsDragging = false
    IsExpanded = false
    IsHovering = false
    HoveredButton = nil
    ActiveButton = nil

    self.AnimationFrames = {}
    self.PendingAnimations = {}
    self.ElementProperties = {}

    if self.ScriptOptions then
        for i = #self.ScriptOptions, 1, -1 do
            if self.ScriptOptions[i] then
                self.ScriptOptions[i] = nil
            end
        end
    end

    if self.AuthorLabels then
        for i = #self.AuthorLabels, 1, -1 do
            if self.AuthorLabels[i] then
                self.AuthorLabels[i] = nil
            end
        end
    end

    self.HoveredElement = nil
    self.LastHoveredIndex = nil
    self.SelectedElement = nil

    setmetatable(self, nil)
end

function AnueHub:AnimateTransparency(element, startValue, endValue, duration)
    local startTime = time()

    spawn(function()
        local elapsed = 0

        while elapsed < duration and ui_running do
            elapsed = time() - startTime
            local progress = math.min(elapsed / duration, 1)
            local eased_progress = progress * (2 - progress) 

            local currentValue = startValue + (endValue - startValue) * eased_progress
            element.Transparency = currentValue

            wait(0.016)
        end

        element.Transparency = endValue
    end)
end

function AnueHub:IsHovered(element)
    if not element or not element.Visible then return false end

    local mouse_pos = getmouselocation(MouseService)
    local pos = element.Position
    local size = element.Size

    if not pos or not size then return false end

    return mouse_pos.x >= pos.x and 
           mouse_pos.x <= pos.x + size.x and 
           mouse_pos.y >= pos.y and 
           mouse_pos.y <= pos.y + size.y
end

function AnueHub:CreateButton(options)

    local background = Drawing.new("Square")
    background.Filled = true
    background.Visible = options.visible or false
    background.Size = options.size or {100, 30}
    background.Position = options.position or {0, 0}
    background.Color = options.color or Colors.ButtonNormal
    background.Transparency = options.transparency or ui_transparency
    table.insert(UIElements, background)

    local border = Drawing.new("Square")
    border.Filled = false
    border.Visible = background.Visible
    border.Size = {background.Size.x, background.Size.y}
    border.Position = {background.Position.x, background.Position.y}
    border.Color = options.borderColor or Colors.Border
    border.Thickness = 1
    border.Transparency = options.transparency or ui_transparency
    table.insert(UIElements, border)

    local text = Drawing.new("Text")
    text.Text = options.text or "Button"
    text.Visible = background.Visible
    text.Color = options.textColor or Colors.Text
    text.Size = options.textSize or text_size
    text.Font = options.font or font 
    text.Transparency = options.textTransparency or text_transparency
    text.Center = true

    text.Position = {
        background.Position.x + (background.Size.x / 2),
        background.Position.y + (background.Size.y / 2) - (text.Size / 2)
    }
    table.insert(TextElements, text)

    local button = {
        Type = "Button",
        Background = background,
        Border = border,
        Text = text,
        Callback = options.callback,
        Hover = false,
        Pressed = false,
        DefaultColor = options.color or Colors.ButtonNormal,
        HoverColor = options.hoverColor or Colors.ButtonHover,
        PressColor = options.pressColor or Colors.ButtonPress,
        BorderColor = options.borderColor or Colors.Border,
        BorderHoverColor = options.borderHoverColor or Colors.Accent,
        ButtonData = options.buttonData or {} 
    }

    table.insert(ButtonElements, button)
    return button
end

function AnueHub:UpdateButtonTextPosition(button)
    if button and button.Background then
        if button.Text then
            button.Text.Position = {
                button.Background.Position.x + (button.Background.Size.x / 2),
                button.Background.Position.y + (button.Background.Size.y / 2) - (button.Text.Size / 2)
            }
            button.Text.Visible = button.Background.Visible
        end

        if button.Border then
            button.Border.Position = {button.Background.Position.x, button.Background.Position.y}
            button.Border.Size = {button.Background.Size.x, button.Background.Size.y}
            button.Border.Visible = button.Background.Visible

            if button.Hover or button.Pressed then
                button.Border.Color = button.BorderHoverColor
            else
                button.Border.Color = button.BorderColor
            end
        end
    end
end

function AnueHub:HandleButtonInteractions()
    spawn(function()
        while ui_running do

            local mouse_location = getmouselocation(MouseService)
            Mouse.X = mouse_location.x
            Mouse.Y = mouse_location.y
            local now_clicked = isleftclicked()
            local now_pressed = isleftpressed()

            local click_completed = Mouse.Pressed and not now_pressed

            Mouse.Clicked = now_clicked
            Mouse.Pressed = now_pressed

            if Mouse.Pressed and not MouseHeld then
                MouseHeld = true

                for _, button in ipairs(ButtonElements) do
                    if button and button.Background and button.Background.Visible and self:IsButtonHovered(button) then
                        ActiveButton = button
                        button.Pressed = true

                        pcall(function()
                            button.Background.Color = button.PressColor
                        end)

                        pcall(function()

                            local original_size = {button.Background.Size.x, button.Background.Size.y}
                            local original_pos = {button.Background.Position.x, button.Background.Position.y}
                            local scale = 0.95

                            button.Background.Size = {
                                original_size[1] * scale,
                                original_size[2] * scale
                            }

                            button.Background.Position = {
                                original_pos[1] + (original_size[1] * (1-scale))/2,
                                original_pos[2] + (original_size[2] * (1-scale))/2
                            }

                            self:UpdateButtonTextPosition(button)
                        end)
                        break
                    end
                end
            elseif click_completed and ActiveButton then

                local button = ActiveButton
                ActiveButton = nil
                MouseHeld = false

                pcall(function() 
                    local original_size = {button.Background.Size.x / 0.95, button.Background.Size.y / 0.95}
                    local original_pos = {
                        button.Background.Position.x - (button.Background.Size.x * (1-0.95))/2 / 0.95,
                        button.Background.Position.y - (button.Background.Size.y * (1-0.95))/2 / 0.95
                    }

                    button.Background.Size = original_size
                    button.Background.Position = original_pos
                    self:UpdateButtonTextPosition(button)
                end)

                if self:IsButtonHovered(button) then

                    if button.Callback then
                        pcall(function()
                            button.Callback()
                        end)
                    end

                    pcall(function() 
                        button.Background.Color = button.HoverColor
                    end)
                else
                    pcall(function() 
                        button.Background.Color = button.DefaultColor
                    end)
                end

                button.Pressed = false
            elseif not Mouse.Pressed and MouseHeld then

                MouseHeld = false
                if ActiveButton then
                    local button = ActiveButton
                    button.Pressed = false
                    ActiveButton = nil

                    pcall(function() 
                        local original_size = {button.Background.Size.x / 0.95, button.Background.Size.y / 0.95}
                        local original_pos = {
                            button.Background.Position.x - (button.Background.Size.x * (1-0.95))/2 / 0.95,
                            button.Background.Position.y - (button.Background.Size.y * (1-0.95))/2 / 0.95
                        }

                        button.Background.Size = original_size
                        button.Background.Position = original_pos
                        self:UpdateButtonTextPosition(button)

                        button.Background.Color = button.DefaultColor
                    end)
                end
            end

            HoveredButton = nil

            for _, button in ipairs(ButtonElements) do
                if button and button.Background and button.Background.Visible and button ~= ActiveButton then
                    local isHovered = self:IsButtonHovered(button)

                    if isHovered then
                        HoveredButton = button
                        button.Hover = true

                        if (button == self.TabAnueButton and selected_tab == 1) or 
                           (button == self.TabCommunityButton and selected_tab == 2) then

                            button.Background.Color = Colors.TabActive
                            if button.Border then
                                button.Border.Color = Colors.Highlight
                            end
                        elseif (button == self.TabAnueButton and selected_tab ~= 1) or 
                               (button == self.TabCommunityButton and selected_tab ~= 2) then

                            if not button.Pressed then
                                pcall(function() 
                                    button.Background.Color = button.HoverColor
                                end)
                            end
                        else

                            if not button.Pressed then
                                pcall(function() 
                                    button.Background.Color = button.HoverColor
                                end)
                            end
                        end
                    else
                        button.Hover = false

                        if (button == self.TabAnueButton and selected_tab == 1) or 
                           (button == self.TabCommunityButton and selected_tab == 2) then

                            button.Background.Color = Colors.TabActive
                            if button.Border then
                                button.Border.Color = Colors.Highlight
                            end
                        elseif (button == self.TabAnueButton and selected_tab ~= 1) or 
                               (button == self.TabCommunityButton and selected_tab ~= 2) then

                            if not button.Pressed then
                                pcall(function() 
                                    button.Background.Color = Colors.TabInactive
                                end)
                                if button.Border then
                                    button.Border.Color = Colors.Border
                                end
                            end
                        else

                            if not button.Pressed then
                                pcall(function() 
                                    button.Background.Color = button.DefaultColor
                                end)
                            end
                        end
                    end
                end
            end

            wait(0.01)
        end
    end)
end

function AnueHub:CreateControlButtons()

    local closeButton = self:CreateButton({
        position = {self.TitleBar.Position.x + self.TitleBar.Size.x - 30, self.TitleBar.Position.y + 5},
        size = {25, 16},
        text = "X",
        textSize = 14,
        color = {60, 20, 20},
        hoverColor = {200, 60, 60},
        pressColor = {150, 30, 30},
        borderColor = {100, 30, 30},
        borderHoverColor = {255, 80, 80},
        visible = true,
        buttonData = {isCloseButton = true},
        callback = function()

            pcall(function()
                self:ToggleUI()
            end)
        end
    })

    local expandButton = self:CreateButton({
        position = {self.TitleBar.Position.x + self.TitleBar.Size.x - 60, self.TitleBar.Position.y + 5},
        size = {25, 16},
        text = IsExpanded and "-" or "+",
        textSize = 14,
        color = {40, 40, 60},
        hoverColor = {60, 60, 100},
        pressColor = {30, 30, 50},
        borderColor = {60, 60, 80},
        borderHoverColor = {100, 100, 200},
        visible = true,
        buttonData = {isExpandButton = true},
        callback = function()

            pcall(function()
                self:ToggleExpanded()
            end)
        end
    })

    self.CloseButton = closeButton
    self.ExpandButton = expandButton

    self._closeButtonText = closeButton.Text
    self._expandButtonText = expandButton.Text

    if self.VersionText then
        self.VersionText.Position = {
            self.ExpandButton.Background.Position.x - 35,
            self.ExpandButton.Background.Position.y + 1
        }
    end
end

function AnueHub:UpdateControlButtonsPosition()
    if self.CloseButton and self.ExpandButton then
        self.CloseButton.Background.Position = {
            self.TitleBar.Position.x + self.TitleBar.Size.x - 30,
            self.TitleBar.Position.y + 5
        }

        self.ExpandButton.Background.Position = {
            self.TitleBar.Position.x + self.TitleBar.Size.x - 60,
            self.TitleBar.Position.y + 5
        }

        self:UpdateButtonTextPosition(self.CloseButton)
        self:UpdateButtonTextPosition(self.ExpandButton)

        if self.VersionText then
            self.VersionText.Position = {
                self.ExpandButton.Background.Position.x - 35,
                self.ExpandButton.Background.Position.y + 1
            }
        end
    end
end

function AnueHub:CheckUIHover()

    local mouse_pos = getmouselocation(MouseService)

    for _, button in ipairs(ButtonElements) do
        if button and button.Background and button.Background.Visible then
            local btn_pos = button.Background.Position
            local btn_size = button.Background.Size
            if mouse_pos.x >= btn_pos.x and 
               mouse_pos.x <= btn_pos.x + btn_size.x and 
               mouse_pos.y >= btn_pos.y and 
               mouse_pos.y <= btn_pos.y + btn_size.y then
                return true, "button", button
            end
        end
    end

    if self.TitleBar and self.TitleBar.Visible then
        local title_pos = self.TitleBar.Position
        local title_size = self.TitleBar.Size
        if mouse_pos.x >= title_pos.x and 
           mouse_pos.x <= title_pos.x + title_size.x and 
           mouse_pos.y >= title_pos.y and 
           mouse_pos.y <= title_pos.y + title_size.y then
            return true, "title", self.TitleBar
        end
    end

    if self.MainFrame and self.MainFrame.Visible then
        local frame_pos = self.MainFrame.Position
        local frame_size = self.MainFrame.Size
        if mouse_pos.x >= frame_pos.x and 
           mouse_pos.x <= frame_pos.x + frame_size.x and 
           mouse_pos.y >= frame_pos.y and 
           mouse_pos.y <= frame_pos.y + frame_size.y then
            return true, "main", self.MainFrame
        end
    end

    return false, nil, nil
end

function AnueHub:IsButtonHovered(button)

    if not button then return false end
    if not button.Background then return false end
    if not button.Background.Visible then return false end

    local mouse_pos = getmouselocation(MouseService)
    if not mouse_pos then return false end

    if type(mouse_pos) ~= "table" and type(mouse_pos) ~= "userdata" then return false end
    if type(mouse_pos.x) ~= "number" or type(mouse_pos.y) ~= "number" then return false end

    local btn_pos = button.Background.Position
    if not btn_pos then return false end

    if type(btn_pos) ~= "table" and type(btn_pos) ~= "userdata" then return false end
    if type(btn_pos.x) ~= "number" or type(btn_pos.y) ~= "number" then return false end

    local btn_size = button.Background.Size
    if not btn_size then return false end

    if type(btn_size) ~= "table" and type(btn_size) ~= "userdata" then return false end
    if type(btn_size.x) ~= "number" or type(btn_size.y) ~= "number" then return false end

    local is_hovered = mouse_pos.x >= (btn_pos.x - 2) and 
           mouse_pos.x <= (btn_pos.x + btn_size.x + 2) and 
           mouse_pos.y >= (btn_pos.y - 2) and 
           mouse_pos.y <= (btn_pos.y + btn_size.y + 2)

    local is_tab_button = false
    if self.TabAnueButton and (button == self.TabAnueButton) then
        is_tab_button = true
        if selected_tab == 1 then
            pcall(function() if button.Background then button.Background.Color = Colors.TabActive end end)
            pcall(function() if button.Border then button.Border.Color = Colors.Highlight end end)
            return is_hovered
        end
    elseif self.TabCommunityButton and (button == self.TabCommunityButton) then
        is_tab_button = true
        if selected_tab == 2 then
            if button.Background then button.Background.Color = Colors.TabActive end
            if button.Border then button.Border.Color = Colors.Highlight end
            return is_hovered
        end
    end

    if is_hovered and button.Border then
        if is_tab_button then

            if (button == self.TabAnueButton and selected_tab ~= 1) or
               (button == self.TabCommunityButton and selected_tab ~= 2) then
                if button.Background then button.Background.Color = Colors.ButtonHover end
                if button.Border then button.Border.Color = Colors.Highlight end
            end
        else

            if button.Border then 
                button.Border.Color = button.BorderHoverColor or Colors.Highlight

                if type(button.Border) == "table" or type(button.Border) == "userdata" then

                    self:SafeSetThickness(button.Border, 2)
                end
            end
        end
    elseif button.Border then
        if is_tab_button then

            if (button == self.TabAnueButton and selected_tab ~= 1) or
               (button == self.TabCommunityButton and selected_tab ~= 2) then
                if button.Background then button.Background.Color = Colors.TabInactive end
                if button.Border then button.Border.Color = Colors.Border end
            end
        else

            if button.Border then
                button.Border.Color = button.BorderColor or Colors.Border

                if type(button.Border) == "table" or type(button.Border) == "userdata" then

                    self:SafeSetThickness(button.Border, 1)
                end
            end
    end
end

    return is_hovered
end

function AnueHub:ExecuteSelectedScript()
    if not IsExpanded then return end

    local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
    local start_index = (current_page - 1) * max_items_per_page + 1
    local selected_script_index = start_index + selected_index - 1

    if selected_script_index <= #active_scripts then
        local script_data = active_scripts[selected_script_index]
        if script_data then
            self:ExecuteScript(script_data)
        end
    end
end

function AnueHub:CheckScriptOptionsHover()
    if not IsExpanded or not self.MainFrame or not self.MainFrame.Visible or IsDragging then 

        IsHovering = false
        return 
    end

    local mouse_pos = getmouselocation(MouseService)
    if not mouse_pos then return end

    local active_scripts = selected_tab == 1 and anue_scripts or community_scripts
    local start_index = (current_page - 1) * max_items_per_page + 1
    local end_index = math.min(start_index + max_items_per_page - 1, #active_scripts)
    local offset = selected_tab == 1 and 0 or #anue_scripts

    local option_spacing = 55

    if not self.ContentFrame or not self.LogoFrame or not self.SelectionHighlight then
        IsHovering = false
        return
    end

    IsHovering = false

    for i = start_index, end_index do
        local element_index = offset + i
        local display_index = (i - start_index) + 1

        if self.ScriptOptions and self.ScriptOptions[element_index] then
            local script_option = self.ScriptOptions[element_index]
            if script_option.Position then
                local script_position = script_option.Position
                local script_height = 45 

                local is_hover = 
                    mouse_pos.x >= self.ContentFrame.Position.x + 10 and 
                    mouse_pos.x <= self.ContentFrame.Position.x + self.ContentFrame.Size.x - 10 and
                    mouse_pos.y >= script_position.y - 8 and 
                    mouse_pos.y <= script_position.y + script_height

                if is_hover then
                    IsHovering = true

                    if MouseHoverIndex ~= display_index then
                        MouseHoverIndex = display_index
                        selected_index = display_index 

                        self:UpdateVisibility()

                        if self.LogoFrame and self.LogoFrame.Position and 
                           self.LogoFrame.Size and self.SelectionHighlight then
                            local start_y = self.LogoFrame.Position.y + self.LogoFrame.Size.y + 15
                            local target_y = start_y + (display_index - 1) * option_spacing - 8

                            self.SelectionHighlight.Size = {self.ContentFrame.Size.x - 20, 45}

                            self.SelectionHighlight.Position = {
                                self.ContentFrame.Position.x + 10,
                                target_y
                            }
                        end
                    end

                    break 
                end
            end
        end
    end

    if not IsHovering then
        MouseHoverIndex = nil
    end
end

function AnueHub:AnimateSelectionHighlight(target_y)

    if not self.SelectionHighlight or not self.ContentFrame then
        return
    end

    if not self.SelectionHighlight.Position or not self.SelectionHighlight.Position.y then
        return
    end

    local current_y = self.SelectionHighlight.Position.y
    local distance = target_y - current_y

    self.SelectionHighlight.Size = {self.ContentFrame.Size.x - 20, 45}

    if math.abs(distance) < 5 then
        self.SelectionHighlight.Position = {
            self.ContentFrame.Position.x + 10,
            target_y
        }
        return
    end

    spawn(function()
        local duration = 0.15 
        local start_time = time()
        local start_y = current_y

        while time() - start_time < duration and ui_running do

            if not self.SelectionHighlight or not self.ContentFrame then
                break
            end

            local progress = (time() - start_time) / duration
            progress = progress * (2 - progress) 

            local new_y = start_y + distance * progress

            pcall(function()
                self.SelectionHighlight.Position = {
                    self.ContentFrame.Position.x + 10,
                    new_y
                }
            end)

            wait(0.01)
        end

        pcall(function()
            if self.SelectionHighlight and self.ContentFrame then
                self.SelectionHighlight.Position = {
                    self.ContentFrame.Position.x + 10,
                    target_y
                }
            end
        end)
    end)
end

function AnueHub:SafeSetThickness(obj, value)
    if not obj then return end

    pcall(function() 
        obj.Thickness = value 
    end)
end

function AnueHub:SafeLoadstring(code)

    local result = {success = false, error = nil}

    if not code or type(code) ~= "string" then
        result.error = "Invalid code type"
        return result
    end

    local env = setmetatable({}, {__index = _G})

    local loaded_fn, load_error = loadstring(code)

    if not loaded_fn then
        result.error = "Failed to load script: " .. tostring(load_error)
        return result
    end

    setfenv(loaded_fn, env)

    local success, exec_error = pcall(function()

        spawn(function()
        loaded_fn()
        end)
    end)

    result.success = success
    if not success then
        result.error = "Error executing script: " .. tostring(exec_error)
    end

    return result
end

return AnueHub:Init()
