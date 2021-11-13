//
//  Checklist.swift
//  RvChecklist
//
//  Created by Ron Lisle on 11/13/21.
//

extension ModelData {
    func initializeList() {
        self.checklist = [
            
            // PRE-TRIP
            ChecklistItem(id: "startList",
                          name: "Start Checklist",
                          category: "Pre-Trip",
                          order: 1010,
                          description: "Start a new checklist"),
            ChecklistItem(id: "checkTires",
                          name: "Check Tires",
                          category: "Pre-Trip",
                          order: 1020,
                          description: "<h1>Check all tire pressures</h1><ul><li>Truck front: 80 psi</li><li>Truck rear: 65 psi</li><li>RV 110 psi</li></ul>"),
            ChecklistItem(id: "dumpTanks",
                          name: "Dump Tanks",
                          category: "Pre-Trip",
                          order: 1030,
                          description: "Dump both black and gray tanks"),
            ChecklistItem(id: "fillWater",
                          name: "Fill Water Tank",
                          category: "Pre-Trip",
                          order: 1040,
                          description: "Fill fresh water tank appropriately"),
            ChecklistItem(id: "fuel",
                          name: "Fill-up Fuel Tanks",
                          category: "Pre-Trip",
                          order: 1050,
                          description: "Calculate amount of fuel needed, and fill tanks appropriately.<p>For shorter trips, get enough for entire trip. <p>For example:<ul><li>Inks Lake is 68 miles.</li><li>Figure 7.5 if hilly, or 9-11 if < 65 mph.</li><li>Main tank is 50 gallons</li><li>Aux tank about 50 more.</li><li>So fill main tank if entire trip < 500 miles.</li><li>Fill aux also if < 1000 miles.</li></ul>"),
            ChecklistItem(id: "fillPropane",
                          name: "Fill-up Propane Tanks",
                          category: "Pre-Trip",
                          order: 1060,
                          description: "Check the level of propane in the 2 propane tanks. Fill tanks if needed.<p>Normally only 1 tank is used at a time. The tank selector points to the primary tank. When it is empty, the gauge will show red. Switch the selector to the other tank and have the empty tank filled while running on other tank.<p>If propane will not be available at destination, may consider filling both tanks.<p>The tank selector switch is on the right side and selects the primary tank. It will show red if the tank is empty, but will draw from the alternate tank if both valves are open.<p>Do not switch the selector until the primary tank is empty. Otherwise both tanks may become partially empty, making it difficult to know how much propane is available."),
            ChecklistItem(id: "checkRoof",
                          name: "Inspect Roof",
                          category: "Pre-Trip",
                          order: 1070,
                          description: "Ensure everything on roof looks ok. Check for leaks, cracks or other damage"),
            ChecklistItem(id: "checkUnderRV",
                          name: "Inspect Under RV",
                          category: "Pre-Trip",
                          order: 1080,
                          description: "Ensure everything under RV looks ok. Check for leaks, and verify flaps under RV not coming loose."),
            ChecklistItem(id: "planRoute",
                          name: "Plan Route",
                          category: "Pre-Trip",
                          order: 1090,
                          description: "Plan route for the trip.<p>Use RV Trip Wizard to identify stops.<p>Identify fuel requirements."),
            
            // DEPARTURE
            ChecklistItem(id: "bedSlideIn",
                          name: "Retract Bedroom Slide",
                          category: "Departure",
                          order: 2010,
                          description: "Retract the bedroom slide. Switch is located on front panel",
                          imageName: "TODO"),
            ChecklistItem(id: "LRSlidesIn",
                          name: "Retract Main Slides",
                          category: "Departure",
                          order: 2020,
                          description: "Retract the living room slides. Switch is located on front panel",
                          imageName: "TODO"),
            ChecklistItem(id: "rampAwningIn",
                          name: "Retract Ramp Awning",
                          category: "Departure",
                          order: 2030,
                          description: "Disconnect ramp awning arms and slide into end rail. Retrack the ramp awning. Switch is located on rear panel"),
            ChecklistItem(id: "closeRamp",
                          name: "Close Ramp",
                          category: "Departure",
                          order: 2040,
                          description: "Remove all furniture on the ramp deck. Roll up carpet. Raise and latch ramp."),
            ChecklistItem(id: "latchHandles",
                          name: "Latch Door Handles",
                          category: "Departure",
                          order: 2050,
                          description: "Close both door handles so they cover door to prevent accidental opening during travel."),
            ChecklistItem(id: "rearAwningIn",
                          name: "Retract Rear Awning",
                          category: "Departure",
                          order: 2060,
                          description: "Retract the rear awning. The switch is located on the rear panel."),
            ChecklistItem(id: "frontAwningIn",
                          name: "Retract Front Awning",
                          category: "Departure",
                          order: 2070,
                          description: "Retract the front awning. Switch is located on front panel"),
            ChecklistItem(id: "discPropane",
                          name: "Disconnect Propane",
                          category: "Departure",
                          order: 2080,
                          description: "Turn off and disconnect big propane tank.<p>Turn off 30 lb tanks while travelling."),
            ChecklistItem(id: "waterHeaterOff",
                          name: "Turn Off Water Heater",
                          category: "Departure",
                          order: 2090,
                          description: "Turn off both propane and electric water heater switches. <p>Switches are located on the front panel."),
            ChecklistItem(id: "hitchTruck",
                          name: "Connect Truck",
                          category: "Departure",
                          order: 2100,
                          description: "Hitch up trailer to truck.<ol><li>Drop tailgate</li><li>Release 5th wheel hitch handle</li><li>Back in truck until kingpin close to hitch</li><li>Raise landing gear until truck and trailer at same height (-1/2 inch)</li><li>Backup truck until hitch latches</li><li>Insert pin to lock hitch</li><li>Connect trailer electrical cable to side connector inside bed</li><li>Connect safety wire to hitch handle</li><li>Rock truck to ensure good latching</li><ol>"),
            ChecklistItem(id: "raiseLG",
                          name: "Raise Landing Gear and Level Up",
                          category: "Departure",
                          order: 2110,
                          description: "Raise the Level-Up and front landing gear.<p>Level-up control is in the basement.<p>Select manual, then retract."),
            ChecklistItem(id: "discPower",
                          name: "Disconnect Shore Power",
                          category: "Departure",
                          order: 2120,
                          description: "Disconnect A/C power cable, and stow away in box in back of truck"),
            
            // ARRIVAL
            ChecklistItem(id: "connectPower",
                          name: "Connect Shore Power",
                          category: "Arrival",
                          order: 3000,
                          description: "Connect power cable from cable in box in back of truck"),
            ChecklistItem(id: "lowerLG",
                          name: "Lower Landing Gear",
                          category: "Arrival",
                          order: 3010,
                          description: "Position pads under landing gear. Then lower landing gear until kingpin just begins to lift off of the hitch. Switch is located outside the RV on the leading wall under the kingpin."),
            ChecklistItem(id: "bedSlideOut",
                          name: "Extend Bedroom Slide",
                          category: "Arrival",
                          order: 3020,
                          description: "Extend the bedroom slide.<p>Switch is located on front panel.<p>Check to ensure nothing has fallen between the slide edges and walls."),
            ChecklistItem(id: "LRSlidesOut",
                          name: "Extend Main Slides",
                          category: "Arrival",
                          order: 3030,
                          description: "Extend the living room slides.<p>Switch is located on front panel.<p>Check to ensure nothing has fallen between the slide edges and walls."),
            ChecklistItem(id: "openRamp",
                          name: "Open Ramp",
                          category: "Arrival",
                          order: 3040,
                          description: "Restore ramp patio.<ul><li>Lower ramp</li><li>Setup railings</li><li>Replace carpet</li><li>Replace all furniture on the ramp deck</li></ul>"),
            ChecklistItem(id: "rampAwningOut",
                          name: "Extend Ramp Awning",
                          category: "Arrival",
                          order: 3050,
                          description: "Extend ramp awning and reconnect ramp awning arms.<p>Switch is located on rear panel"),
            ChecklistItem(id: "stepsDown",
                          name: "Restore Door Steps and Handles",
                          category: "Arrival",
                          order: 3060,
                          description: "Open both door handles and lower steps."),
            ChecklistItem(id: "rearAwningOut",
                          name: "Extend Rear Awning",
                          category: "Arrival",
                          order: 3070,
                          description: "Extend the rear awning. The switch is located on the rear panel."),
            ChecklistItem(id: "frontAwningOut",
                          name: "Extend Front Awning",
                          category: "Arrival",
                          order: 3080,
                          description: "Extend the front awning. Switch is located on front panel"),
            ChecklistItem(id: "propaneOn",
                          name: "Turn On Propane",
                          category: "Arrival",
                          order: 3090,
                          description: "Turn on 30 lb. tanks when traveling.<p>Tanks are located on both sides of RV near the front<p>While at home, connect large propane tank to quick connect fitting under right side of RV"),
            ChecklistItem(id: "waterHose",
                          name: "Connect Water Hose",
                          category: "Arrival",
                          order: 3100,
                          description: "Connect and turn on water hose.<p>Route the hose up through the hole at the bottom of the water closet"),
            ChecklistItem(id: "sewerHose",
                          name: "Connect Sewer Hoses",
                          category: "Arrival",
                          order: 3110,
                          description: "Optionally, connected sewer hose to 1 or both sewer fittings.<p>For shorter stays, may skip this, or just connect the front to allow showers.")
            ]

    }
}
