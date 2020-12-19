function GetContentSettings1()
    local output = ""
    output = output .. GetHeader("Settings") .. [[<rect class="xfill" x="40" y="150" rx="5" ry="5" width="820" height="50" />]]
    if BackgroundMode=="" then
        output = output ..[[<text class="f30mxxx" x="440" y="185">Activate background</text>]]
    else
        output = output ..[[<text class="f30mxxx" x="440" y="185">Deactivate background (']]..BackgroundMode..[[', ]]..string.format("%.0f",BackgroundModeOpacity*100)..[[%)</text>]]
    end
    output = output ..[[
        <rect class="xfill" x="40" y="220" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="240" y="255">Previous background</text>
        <rect class="xfill" x="460" y="220" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="660" y="255">Next background</text>

        <rect class="xfill" x="40" y="290" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="240" y="325">Decrease Opacity</text>
        <rect class="xfill" x="460" y="290" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="660" y="325">Increase Opacity</text>
    ]]

    output = output ..
        [[<rect class="xfill" x="40" y="360" rx="5" ry="5" width="820" height="50" />]] ..
        [[<text class="f30mxxx" x="440" y="395">Reset background and all colors</text>]]

    output = output ..
        [[<svg x=40 y=430 width=820 height=574>]] ..
            [[<rect class="xborder" x="0" y="0" rx="5" ry="5" width="820" height="574" stroke-dasharray="2 5" />]] ..
            [[<rect class="xborder" x="0" y="0" rx="5" ry="5" width="820" height="50" />]] ..
            [[<text class="f30mxx" x="410" y="35">Select and change any of the ]]..#colorIDTable..[[ HUD colors</text>]] ..
            [[<rect class="xfill" x="20" y="70" rx="5" ry="5" width="50" height="50" />]] ..
                [[<svg x=32 y=74><path d="M1,23.13,16.79,40.25a3.23,3.23,0,0,0,5.6-2.19V3.24a3.23,3.23,0,0,0-5.6-2.19L1,18.17A3.66,3.66,0,0,0,1,23.13Z" transform="translate(0.01 -0.01)"/></svg>]] ..
            [[<rect class="xfill" x="750" y="70" rx="5" ry="5" width="50" height="50" />]] ..
                [[<svg x=764 y=74><path d="M21.42,18.17,5.59,1.05A3.23,3.23,0,0,0,0,3.24V38.06a3.23,3.23,0,0,0,5.6,2.19L21.42,23.13A3.66,3.66,0,0,0,21.42,18.17Z" transform="translate(0.01 -0.01)"/></svg>]] ..
            [[<rect class="xborder" x="90" y="70" rx="5" ry="5" width="640" height="50" />]] ..
            [[<text class="f30mxx" x="410" y="105">]]..colorIDTable[colorIDIndex].desc..[[</text>]] ..
            [[<rect style="fill: #]].._G[colorIDTable[colorIDIndex].id]..[[; fill-opacity: 1; stroke: #]]..ColorPrimary..[[; stroke-width:3;" x="90" y="140" rx="5" ry="5" width="640" height="70" />]] ..
            [[<text class="f20sxx" x="100" y="160">Current color</text>]] ..
            [[<svg x=90 y=230 width=640 height=140>]] ..

                [[<rect class=xbfill x=55 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=75 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=145 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=165 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=235 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=255 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=325 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=345 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=415 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=435 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=505 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=525 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..

                [[<text class=f60mx x=27 y=92>#</text>]] ..

                [[<rect class=xborder x=55 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=95 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,1,1)..[[</text>]] ..
                [[<rect class=xborder x=145 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=185 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,2,2)..[[</text>]] ..
                [[<rect class=xborder x=235 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=275 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,3,3)..[[</text>]] ..
                [[<rect class=xborder x=325 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=365 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,4,4)..[[</text>]] ..
                [[<rect class=xborder x=415 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=455 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,5,5)..[[</text>]] ..
                [[<rect class=xborder x=505 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=545 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,6,6)..[[</text>]] ..

                [[<rect class=xbfill x=55 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=75 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=145 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=165 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=235 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=255 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=325 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=345 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=415 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=435 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=505 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=525 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..

            [[</svg>]] ..
            [[<rect style="fill: #]]..colorIDTable[colorIDIndex].newc..[[; fill-opacity: 1; stroke: #]]..ColorPrimary..[[; stroke-width:3;" x="90" y="390" rx="5" ry="5" width="640" height="70" />]] ..
            [[<text class=f20sxx x=100 y=410>New color</text>]] ..
            [[<rect class=xfill x=290 y=480 rx=5 ry=5 width=440 height=50 />]] ..
            [[<text class=f30mxxx x=510 y=515>Apply new color</text>]] ..
            [[<rect class=xfill x=90 y=480 rx=5 ry=5 width=185 height=50 />]] ..
            [[<text class=f30mxxx x=182 y=515>Reset</text>]] ..
        [[</svg>]]

    output = output ..
            [[<svg x=940 y=150 width=936 height=774>]] ..
                [[<rect class=xborder x=0 y=0 rx=5 ry=5 width=936 height=774 stroke-dasharray="2 5" />]] ..
                [[<rect class=xborder x=0 y=0 rx=5 ry=5 width=936 height=50 />]] ..
                [[<text class=f30mxx x=468 y=35>Explanation / Hints</text>]] ..
                [[<text class=f30mxx x=468 y=400>Coming soon.</text>]]


    output = output .. [[</svg>]]

    if SimulationMode == true then
        output = output .. [[<rect class="cfill" x="940" y="954" rx="5" ry="5" width="936" height="50" /><text class="f30mxxx" x="1408" y="989">Simulating Damage to elements</text>]]
        AddClickArea("settings1", { id = "ToggleSimulation", mode ="settings1", x1 = 940, x2 = 1850, y1 = 919, y2 = 969 })
    else
        output = output .. [[<rect class="xfill" x="940" y="954" rx="5" ry="5" width="936" height="50" /><text class="f30mxxx" x="1408" y="989">Simulate Damage to elements</text>]]
        AddClickArea("settings1", { id = "ToggleSimulation", mode ="settings1", x1 = 940, x2 = 1850, y1 = 919, y2 = 969 })
    end

    return output
end