#!/bin/bash
curl -s -X PUT "localhost:9200/unassigned_shard_demo" -H "Content-Type: application/json" -d '{"settings":{"number_of_shards":1,"number_of_replicas":10}}'
cat <<-EOF | curl -H "Content-Type: application/json" -X POST --data-binary @- localhost:9200/product/_bulk | jq
{"index":{ "_id": "P0"}}
{"name":"Smartphone","description":"A handheld device that combines a mobile phone with computing functions.","category":"Electronics","price":599.99}
{"index":{ "_id": "P1"}}
{"name":"Laptop","description":"A portable computer that can be easily carried and used in various locations.","category":"Electronics","price":999.99}
{"index":{ "_id": "P2"}}
{"name":"Running Shoes","description":"Lightweight shoes designed for running and jogging activities.","category":"Sports & Outdoors","price":79.99}
{"index":{ "_id": "P3"}}
{"name":"Cookware Set","description":"A collection of pots, pans, and other cooking utensils for preparing meals.","category":"Home & Kitchen","price":149.99}
{"index":{ "_id": "P4"}}
{"name":"Fiction Book","description":"A literary work of prose that is based on imagination and storytelling.","category":"Books","price":14.99}
{"index":{ "_id": "P5"}}
{"name":"Headphones","description":"Audio devices worn on the head to listen to audio content privately.","category":"Electronics","price":129.99}
{"index":{ "_id": "P6"}}
{"name":"Tennis Racket","description":"A piece of sports equipment used for playing tennis.","category":"Sports & Outdoors","price":89.99}
{"index":{ "_id": "P7"}}
{"name":"Coffee Maker","description":"A machine used to brew coffee.","category":"Home & Kitchen","price":79.99}
{"index":{ "_id": "P8"}}
{"name":"Sci-Fi Book","description":"A genre of speculative fiction that explores imaginative and futuristic concepts.","category":"Books","price":19.99}
{"index":{ "_id": "P9"}}
{"name":"Wireless Mouse","description":"A computer mouse that uses wireless technology to connect to a computer.","category":"Electronics","price":29.99}
{"index":{ "_id": "P10"}}
{"name":"Yoga Mat","description":"A cushioned mat used for practicing yoga exercises.","category":"Sports & Outdoors","price":49.99}
{"index":{ "_id": "P11"}}
{"name":"Blender","description":"A kitchen appliance used to mix, purée, or emulsify food and other substances.","category":"Home & Kitchen","price":39.99}
{"index":{ "_id": "P12"}}
{"name":"Mystery Book","description":"A genre of fiction that involves a mysterious event to be solved.","category":"Books","price":24.99}
{"index":{ "_id": "P13"}}
{"name":"LED TV","description":"A television set that uses light-emitting diodes to produce images.","category":"Electronics","price":799.99}
{"index":{ "_id": "P14"}}
{"name":"Hiking Backpack","description":"A backpack designed specifically for hiking and outdoor activities.","category":"Sports & Outdoors","price":149.99}
{"index":{ "_id": "P15"}}
{"name":"Toaster","description":"A kitchen appliance used to toast bread slices.","category":"Home & Kitchen","price":29.99}
{"index":{ "_id": "P16"}}
{"name":"Horror Book","description":"A genre of literature that is intended to scare, unsettle, or horrify the audience.","category":"Books","price":17.99}
{"index":{ "_id": "P17"}}
{"name":"Digital Camera","description":"A camera that captures photographs and stores them digitally.","category":"Electronics","price":399.99}
{"index":{ "_id": "P18"}}
{"name":"Treadmill","description":"A device used for walking or running while staying in one place.","category":"Sports & Outdoors","price":999.99}
{"index":{ "_id": "P19"}}
{"name":"Rice Cooker","description":"A kitchen appliance used to cook rice automatically.","category":"Home & Kitchen","price":59.99}
{"index":{ "_id": "P20"}}
{"name":"Thriller Book","description":"A genre of fiction that is characterized by excitement, suspense, and surprise endings.","category":"Books","price":21.99}
{"index":{ "_id": "P21"}}
{"name":"Smart Watch","description":"A wearable device that offers various functionalities like tracking fitness metrics and receiving notifications.","category":"Electronics","price":199.99}
{"index":{ "_id": "P22"}}
{"name":"Basketball","description":"A spherical inflated ball used in the game of basketball.","category":"Sports & Outdoors","price":29.99}
{"index":{ "_id": "P23"}}
{"name":"Stand Mixer","description":"A kitchen appliance used for mixing ingredients.","category":"Home & Kitchen","price":249.99}
{"index":{ "_id": "P24"}}
{"name":"Romance Book","description":"A genre of fiction that focuses on romantic love stories.","category":"Books","price":18.99}
{"index":{ "_id": "P25"}}
{"name":"Wireless Earbuds","description":"Earphones that are not connected to a device by a cable.","category":"Electronics","price":149.99}
{"index":{ "_id": "P26"}}
{"name":"Soccer Ball","description":"A spherical ball used in the game of soccer.","category":"Sports & Outdoors","price":19.99}
{"index":{ "_id": "P27"}}
{"name":"Dishwasher","description":"A kitchen appliance used for cleaning dishes automatically.","category":"Home & Kitchen","price":399.99}
{"index":{ "_id": "P28"}}
{"name":"Historical Fiction Book","description":"A genre of fiction that takes place in the past and often includes real historical events.","category":"Books","price":22.99}
{"index":{ "_id": "P29"}}
{"name":"Tablet","description":"A portable computing device with a touchscreen display.","category":"Electronics","price":299.99}
{"index":{ "_id": "P30"}}
{"name":"Camping Tent","description":"A shelter consisting of sheets of fabric or other material draped over or attached to a frame of poles.","category":"Sports & Outdoors","price":199.99}
{"index":{ "_id": "P31"}}
{"name":"Air Fryer","description":"A kitchen appliance that cooks by circulating hot air around the food.","category":"Home & Kitchen","price":119.99}
{"index":{ "_id": "P32"}}
{"name":"Biography Book","description":"A genre of literature that focuses on the lives of real people.","category":"Books","price":16.99}
{"index":{ "_id": "P33"}}
{"name":"Fitness Tracker","description":"A wearable device that monitors and tracks fitness-related metrics.","category":"Electronics","price":79.99}
{"index":{ "_id": "P34"}}
{"name":"Fishing Rod","description":"A long, flexible rod used in the sport of fishing.","category":"Sports & Outdoors","price":49.99}
{"index":{ "_id": "P35"}}
{"name":"Microwave Oven","description":"An electric oven that heats and cooks food by exposing it to electromagnetic radiation.","category":"Home & Kitchen","price":99.99}
{"index":{ "_id": "P36"}}
{"name":"Self-Help Book","description":"A genre of literature that offers advice and guidance on personal growth and self-improvement.","category":"Books","price":20.99}
{"index":{ "_id": "P37"}}
{"name":"Virtual Reality Headset","description":"A head-mounted display that provides virtual reality experiences for the user.","category":"Electronics","price":499.99}
{"index":{ "_id": "P38"}}
{"name":"Hiking Boots","description":"Specialized footwear designed for hiking and outdoor activities.","category":"Sports & Outdoors","price":129.99}
{"index":{ "_id": "P39"}}
{"name":"Juicer","description":"A kitchen appliance used to extract juice from fruits and vegetables.","category":"Home & Kitchen","price":49.99}
{"index":{ "_id": "P40"}}
{"name":"Science Fiction Book","description":"A genre of speculative fiction that explores imaginative and futuristic concepts.","category":"Books","price":23.99}
{"index":{ "_id": "P41"}}
{"name":"Gaming Console","description":"A specialized computer system designed for playing video games.","category":"Electronics","price":399.99}
{"index":{ "_id": "P42"}}
{"name":"Cycling Helmet","description":"A protective headgear worn by cyclists to reduce the risk of head injuries.","category":"Sports & Outdoors","price":39.99}
{"index":{ "_id": "P43"}}
{"name":"Waffle Maker","description":"A kitchen appliance used to make waffles.","category":"Home & Kitchen","price":39.99}
{"index":{ "_id": "P44"}}
{"name":"Poetry Book","description":"A literary genre that uses aesthetic and rhythmic qualities of language to evoke meanings.","category":"Books","price":15.99}
{"index":{ "_id": "P45"}}
{"name":"Bluetooth Speaker","description":"A portable speaker that connects to devices via Bluetooth technology.","category":"Electronics","price":79.99}
{"index":{ "_id": "P46"}}
{"name":"Camping Sleeping Bag","description":"A portable insulated sleeping bag designed for camping.","category":"Sports & Outdoors","price":69.99}
{"index":{ "_id": "P47"}}
{"name":"Rice Cooker","description":"A kitchen appliance used to cook rice automatically.","category":"Home & Kitchen","price":59.99}
{"index":{ "_id": "P48"}}
{"name":"Art Book","description":"A genre of literature that focuses on art-related topics.","category":"Books","price":24.99}
{"index":{ "_id": "P49"}}
{"name":"Wireless Keyboard","description":"A computer keyboard that connects to a computer via wireless technology.","category":"Electronics","price":49.99}
{"index":{ "_id": "P50"}}
{"name":"Cycling Gloves","description":"Gloves designed to provide protection and comfort to cyclists.","category":"Sports & Outdoors","price":19.99}
{"index":{ "_id": "P51"}}
{"name":"Slow Cooker","description":"A kitchen appliance used for cooking food at a low temperature over a long period of time.","category":"Home & Kitchen","price":69.99}
{"index":{ "_id": "P52"}}
{"name":"Artificial Intelligence Book","description":"A genre of literature that explores the theory and practice of artificial intelligence.","category":"Books","price":29.99}
{"index":{ "_id": "P53"}}
{"name":"Wireless Router","description":"A networking device that forwards data packets between computer networks.","category":"Electronics","price":89.99}
{"index":{ "_id": "P54"}}
{"name":"Swimming Goggles","description":"Goggles worn to protect the eyes while swimming.","category":"Sports & Outdoors","price":14.99}
{"index":{ "_id": "P55"}}
{"name":"Instant Pot","description":"A brand of multi-functional pressure cooker.","category":"Home & Kitchen","price":129.99}
{"index":{ "_id": "P56"}}
{"name":"Computer Monitor","description":"A display screen used to provide visual output from a computer.","category":"Electronics","price":199.99}
{"index":{ "_id": "P57"}}
{"name":"Golf Clubs","description":"A set of clubs used in the sport of golf.","category":"Sports & Outdoors","price":299.99}
{"index":{ "_id": "P58"}}
{"name":"Vacuum Cleaner","description":"A device that uses an air pump to create a partial vacuum to suck up dust and dirt.","category":"Home & Kitchen","price":149.99}
{"index":{ "_id": "P59"}}
{"name":"Classic Literature Book","description":"A genre of literature that includes works considered to be of high literary quality.","category":"Books","price":26.99}
{"index":{ "_id": "P60"}}
{"name":"External Hard Drive","description":"A portable storage device that connects to a computer via USB or other interfaces.","category":"Electronics","price":129.99}
{"index":{ "_id": "P61"}}
{"name":"Hiking Jacket","description":"A waterproof and windproof jacket designed for hiking and outdoor activities.","category":"Sports & Outdoors","price":199.99}
{"index":{ "_id": "P62"}}
{"name":"Coffee Grinder","description":"A kitchen appliance used to grind roasted coffee beans.","category":"Home & Kitchen","price":39.99}
{"index":{ "_id": "P63"}}
{"name":"Fantasy Book","description":"A genre of fiction that features magical and supernatural elements.","category":"Books","price":28.99}
{"index":{ "_id": "P64"}}
{"name":"Smart Thermostat","description":"A programmable thermostat that can be controlled remotely via a smartphone app.","category":"Electronics","price":149.99}
{"index":{ "_id": "P65"}}
{"name":"Baseball Bat","description":"A smooth wooden or metal club used in the sport of baseball to hit the ball after it is thrown by the pitcher.","category":"Sports & Outdoors","price":49.99}
{"index":{ "_id": "P66"}}
{"name":"Electric Kettle","description":"A kitchen appliance used to boil water quickly.","category":"Home & Kitchen","price":24.99}
{"index":{ "_id": "P67"}}
{"name":"Travel Guide Book","description":"A book that provides information for travelers about a particular destination.","category":"Books","price":19.99}
{"index":{ "_id": "P68"}}
{"name":"Smart Plug","description":"A plug that can be controlled remotely via a smartphone app.","category":"Electronics","price":19.99}
{"index":{ "_id": "P69"}}
{"name":"Camping Chair","description":"A portable chair designed for camping and outdoor activities.","category":"Sports & Outdoors","price":29.99}
{"index":{ "_id": "P70"}}
{"name":"Food Processor","description":"A kitchen appliance used for chopping, slicing, and shredding food.","category":"Home & Kitchen","price":79.99}
{"index":{ "_id": "P71"}}
{"name":"Travel Memoir Book","description":"A genre of literature that recounts the author's experiences and adventures while traveling.","category":"Books","price":15.99}
{"index":{ "_id": "P72"}}
{"name":"Smart Bulb","description":"A light bulb that can be controlled remotely via a smartphone app.","category":"Electronics","price":24.99}
{"index":{ "_id": "P73"}}
{"name":"Camping Stove","description":"A portable stove used for cooking outdoors during camping trips.","category":"Sports & Outdoors","price":49.99}
{"index":{ "_id": "P74"}}
{"name":"Kitchen Scale","description":"A device used to accurately measure the weight of ingredients in cooking.","category":"Home & Kitchen","price":19.99}
{"index":{ "_id": "P75"}}
{"name":"Travelogue Book","description":"A genre of literature that presents the author's experiences and observations during travels.","category":"Books","price":16.99}
{"index":{ "_id": "P76"}}
{"name":"Smart Doorbell","description":"A doorbell equipped with a camera and Wi-Fi connectivity, allowing homeowners to monitor their doorstep remotely.","category":"Electronics","price":199.99}
{"index":{ "_id": "P77"}}
{"name":"Tennis Balls","description":"Balls used in the sport of tennis.","category":"Sports & Outdoors","price":9.99}
{"index":{ "_id": "P78"}}
{"name":"Bread Maker","description":"A kitchen appliance used to bake bread automatically.","category":"Home & Kitchen","price":79.99}
{"index":{ "_id": "P79"}}
{"name":"Travel Fiction Book","description":"A genre of literature that features fictional stories set in various travel destinations.","category":"Books","price":18.99}
{"index":{ "_id": "P80"}}
{"name":"Smart Door Lock","description":"A door lock that can be remotely controlled via a smartphone app.","category":"Electronics","price":149.99}
{"index":{ "_id": "P81"}}
{"name":"Golf Balls","description":"Balls used in the sport of golf.","category":"Sports & Outdoors","price":19.99}
{"index":{ "_id": "P82"}}
{"name":"Electric Pressure Cooker","description":"A kitchen appliance that cooks food quickly under pressure.","category":"Home & Kitchen","price":129.99}
{"index":{ "_id": "P83"}}
{"name":"Travel Photography Book","description":"A book that showcases travel photography from various destinations.","category":"Books","price":29.99}
{"index":{ "_id": "P84"}}
{"name":"Wireless Charging Pad","description":"A device that charges electronic devices wirelessly.","category":"Electronics","price":39.99}
{"index":{ "_id": "P85"}}
{"name":"Cycling Shoes","description":"Specialized shoes designed for cycling.","category":"Sports & Outdoors","price":99.99}
{"index":{ "_id": "P86"}}
{"name":"Food Dehydrator","description":"A kitchen appliance used to remove moisture from food to preserve it.","category":"Home & Kitchen","price":59.99}
{"index":{ "_id": "P87"}}
{"name":"Travel Adventure Book","description":"A genre of literature that recounts exciting and adventurous travel experiences.","category":"Books","price":22.99}
{"index":{ "_id": "P88"}}
{"name":"Wireless Security Camera","description":"A surveillance camera that connects to a Wi-Fi network and can be accessed remotely.","category":"Electronics","price":79.99}
{"index":{ "_id": "P89"}}
{"name":"Golf Gloves","description":"Gloves designed to provide grip and protection to golfers while playing.","category":"Sports & Outdoors","price":19.99}
{"index":{ "_id": "P90"}}
{"name":"Air Purifier","description":"A device that removes contaminants from the air to improve indoor air quality.","category":"Home & Kitchen","price":199.99}
{"index":{ "_id": "P91"}}
{"name":"Travel Journal","description":"A notebook used to record travel experiences, observations, and memories.","category":"Books","price":14.99}
{"index":{ "_id": "P92"}}
{"name":"Air Purifier","description":"Improve your indoor air quality with this air purifier. Removes dust, allergens, and odors from the air.","category":"Home & Kitchen","price":74.99}
{"index":{ "_id": "P93"}}
{"name":"Science Fiction Novel","description":"Embark on a thrilling journey through space in this captivating science fiction novel.","category":"Books","price":14.99}
{"index":{ "_id": "P94"}}
{"name":"Portable Speaker","description":"Enjoy your music anywhere with this portable speaker. Features Bluetooth connectivity and long battery life.","category":"Electronics","price":59.99}
{"index":{ "_id": "P95"}}
{"name":"Yoga Mat","description":"Find your inner peace with this comfortable and non-slip yoga mat. Perfect for all levels of practice.","category":"Sports & Outdoors","price":29.95}
{"index":{ "_id": "P96"}}
{"name":"Toaster Oven","description":"Toast, bake, and broil with ease with this versatile toaster oven. Perfect for small kitchens or apartments.","category":"Home & Kitchen","price":64.99}
{"index":{ "_id": "P97"}}
{"name":"Camping Tent","description":"Spacious and weatherproof camping tent for all your outdoor adventures. Easy to set up and take down.","category":"Sports & Outdoors","price":124.99}
{"index":{ "_id": "P98"}}
{"name":"Coffee Maker","description":"Start your day off right with this programmable coffee maker. Brews a delicious pot of coffee every time.","category":"Home & Kitchen","price":34.99}
{"index":{ "_id": "P99"}}
{"name": "Fantasy Adventure Novel","description": "Explore a magical world filled with wonder and adventure in this epic fantasy novel.","category": "Books","price": 1}
EOF



