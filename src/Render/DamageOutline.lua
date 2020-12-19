function GetContentDamageoutline(screen)
    UpdateDataDamageoutline()
    UpdateViewDamageoutline(screen)
    local output = ""
    output = output .. GetHeader("Damage Ship Outline Report") ..
    GetDamageoutlineShip() .. 
    [[<rect x=20 y=180 rx=5 ry=5 width=1880 height=840 fill=#000000 fill-opacity=0.5 style="stroke:#]]..ColorPrimary..[[;stroke-width:3;" />]]

    if screen.submode=="top" then
        output = output ..
            [[
              <rect class=xfill x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=220 y=165>Top View</text>
              <rect class=xborder x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=620 y=165>Side View</text>
              <rect class=xborder x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=1020 y=165>Front View</text>
            ]]
    elseif screen.submode=="side" then
        output = output ..
            [[
              <rect class=xborder x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=220 y=165>Top View</text>
              <rect class=xfill x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=620 y=165>Side View</text>
              <rect class=xborder x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=1020 y=165>Front View</text>
            ]]
    elseif screen.submode=="front" then
        output = output ..
            [[
              <rect class=xborder x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=220 y=165>Top View</text>
              <rect class=xborder x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=620 y=165>Side View</text>
              <rect class=xfill x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=1020 y=165>Front View</text>
            ]]
    else
    end
    output = output .. [[<text class=f30exx x=1900 y=120>]]..#dmgoElements..[[ of ]]..ElementCounter..[[ shown</text>]]
    output = output .. [[<rect class=xborder x=1550 y=130 rx=5 ry=5 width=50 height=50 />]]
    if DMGOStretch == true then
        output = output .. [[<rect class=xfill x=1558 y=138 rx=5 ry=5 width=34 height=34 />]]
    end
    output = output .. [[<text class=f30exx x=1900 y=165>Stretch both axis</text>]]
    return output
end