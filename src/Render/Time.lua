function GetContentTime()
    local output = ""
    output = output .. GetHeader("Time") .. epochTime()
    output = output ..
                [[<svg x=460 y=370 width=120 height=150 viewBox="0 0 24 30">
                    <rect x=0 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0s" dur="1s" repeatCount="indefinite" />
                    </rect>
                    <rect x=10 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0.15s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0.15s" dur="1s" repeatCount="indefinite" />
                    </rect>
                    <rect x=20 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0.3s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0.3s" dur="1s" repeatCount="indefinite" />
                    </rect>
                  </svg>]]
    return output
end