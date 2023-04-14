# Diablo Rougelike (Early Access)
Diablo Rougelike is a small text-based RPG rougelike game, where you can use one of 3 classes to explore rooms in a map, solve random challenges and fight a finall boss.

Classes:

1. Barbarian: Has the highest HP in the game with ok damage, makes it the survivor and suitable for exploring the maps
	- HP: 200
	- Damage: 15
2. Sorcerer: Lowest HP but has highest damage, great for a quick run and fighting the boss
	- HP: 100
	- Damage: 50
3. Rouge: Average HP and average damage makes this class able to handle everything
	- HP: 150
	- Damage: 35

---
## Preparation for playing
### Required environment
- Ruby 3.1.2
- Bundler 2.4.12

### Test
RSpec tests. 100% coverage (Simplecov)

```bash
$ rspec

Finished in 0.01482 seconds (files took 0.09824 seconds to load)
25 examples, 0 failures
435 / 435 LOC (100.0%) covered.
```
* 100% test coverage doesn't guarantee it's bug free but I have tested it based on my available time

### Instanllation
```bash
git clone git@github.com:treatwell-talents/code-challenge-ruby-game-bank-lee.git
cd code-challenge-ruby-game-bank-lee
bundle install
```

### How to start the game
This implementation includes a bundle command for easy usage
```bash
bundle exec bin/play
```

This starts the game with a `3 x 3` map where you can explore with you chosen class. 
Entering a room has a 50/50 chance to present you an easy (!?) math challenge, which needed to be resolve before going to next room


Below is a run history for demo purpose, feel free to play with your character and class.
```
$ bundle exec bin/play

========== Diablo Rougelike ==========

Greetings adventurer, what's your name?
Bank

Bank, what class do you want to play this time?
There are 3 classes you can choose from: Barbarian, Sorcerer and Rouge
Barbarian
Barbarian - great choice! Let's go for a run!

You entered the room 0-0.
You are in a room look like warm cyberpunk barrier
You need to solve this challenge before you can go anywhere
90 + 22
112
Challenge completed!
What do you do?
[W] Go North
[D] Go East
W
Go North

You entered the room 0-1.
You are in a room look like terrible darkside barrier
You need to solve this challenge before you can go anywhere
79 - 34
45
Challenge completed!
What do you do?
[W] Go North
[D] Go East
[S] Go South
D
Go East

You entered the room 1-1.
You are in a room look like old stoneage room
You need to solve this challenge before you can go anywhere
39 / 63
0
Challenge completed!
What do you do?
[W] Go North
[A] Go West
[D] Go East
[S] Go South
help
==========================================================================================
Movement:
  - Use [W, A, S ,D] (case sensitive) to move around the rooms

How to win the game:
  - You need to go to the final room and fight the boss

Game Over:
  - If your character HP <= 0

Random challenges:
  - You might get some easy math challenges while you enter the room
  - There is no challenges in final room
  - If you having troubles in calculating, there are tips:
    - Use calculator
    - Use cheat code by entering exact wording of challenge (on your own risk)
      - Example: '5 + 10'
==========================================================================================
What do you do?
[W] Go North
[A] Go West
[D] Go East
[S] Go South
D
Go East

You entered the room 2-1.
You are in a room look like warm cyberpunk barrier
You need to solve this challenge before you can go anywhere
46 + 45
91
Challenge completed!
What do you do?
[W] Go North
[A] Go West
[S] Go South
W
Go North

You entered the room FINAL.
You are in a room look like terrible darkside castle

You have encountered an enemy: BOSS
Battle started!
Bank attacked BOSS, caused 15 damages
BOSS HP: 85
BOSS attacked Bank, caused 20 damages
Bank HP: 180
Bank attacked BOSS, caused 15 damages
BOSS HP: 70
BOSS attacked Bank, caused 20 damages
Bank HP: 160
Bank attacked BOSS, caused 15 damages
BOSS HP: 55
BOSS attacked Bank, caused 20 damages
Bank HP: 140
Bank attacked BOSS, caused 15 damages
BOSS HP: 40
BOSS attacked Bank, caused 20 damages
Bank HP: 120
Bank attacked BOSS, caused 15 damages
BOSS HP: 25
BOSS attacked Bank, caused 20 damages
Bank HP: 100
Bank attacked BOSS, caused 15 damages
BOSS HP: 10
BOSS attacked Bank, caused 20 damages
Bank HP: 80
Bank attacked BOSS, caused 15 damages
BOSS HP: -5
Bank has won the battle with 80 HP left
Congratulations Bank, you have won the game by using Barbarian
```

### One more thing
You can type `help` (case insensitive) when you are in rooms to get quick help. The `help` command doesn't work (yet) if you are in middle of solving challenges.
```
Movement:
  - Use [W, A, S ,D] (case sensitive) to move around the rooms

How to win the game:
  - You need to go to the final room and fight the boss

Game Over:
  - If your character HP <= 0

Random challenges:
  - You might get some easy math challenges while you enter the room
  - There is no challenges in final room
  - If you having troubles in calculating, there are tips:
    - Use calculator
    - Use cheat code by entering exact wording of challenge (on your own risk)
      - Example: '5 + 10'
```

---
## First impression on the code challenge
- Very creative and enjoyable code challenge, which is challenging enough to evaluate a developer's skills and a perfect match for who has a side project making a game in Unity.


## Implementation approaches explained
A bit mix of DDD/BDD/TDD approaches as the requirements seems clear but include no expecting win/lose conditions nor the game/battle/challenge flow.

### 1. Ideas/questions before implementation
1. Based on my understanding to key points (requirements), the rough idea for key elements of this game are:
	- Rooms/Map
	- Player input handling
	- Random event/challenges
	- Final battle
	- Help
2. Unclear area (in no specific order):
	- Game flow: win/lose condition provided so made an assumption
	- Battle and/or Challenge flow: seems could happen at the same time at final room, assume battle happens before challenges (and win the game)
	- Player input format: provided examples use numbers, but using WASD seems better for user experience (so no dynamic order for moving to the same direction)
	- Challenge types: seems 2 different type of challenges - one random happen while entering the game and another static in room options
	- Battle: doesn't indicate battle type and what kinda boss might be

### 2. Early stage - exploring requirements and make a PoC/MVP with mock objects
1. Minimum OOD at this stage as I was still exploring domain objects and its interfaces
2. Explored and implemented basic game flow (win condition path) with basic functions and mock objects
3. Implemented each function as simple as possible and make it work (with passed tests) to fit the requirements
4. Once it works, implement next function, rather than refactoring as most of TDD guide told you to do so
5. Repeat step 3 until all requirements are fit, so we know we have a PoC/MVP.

### 3. Middle stage - Refactoring and OOD/OOP
1. After reviewing the PoC and requirements, I though there were few domain object/class candidates: 
	- Game: The entry point of the game, controls game flow (win/lose conditions) and player input
	- Map: Represents collection of rooms and its position and available movements
	- Room: Handles random descriptions and chance if there should be a challenge while entering
	- Challenge: To generate random challenges
	- Battle: For final boss, but it could be used in other rooms (potential enhancement)
	- Character: Define player/NPC and for battle purpose
2. Started with Map and Room as top 3 requirements relates to (room numbers, description and movements)
3. Challenge follows, then Battle and Character
4. Started refactoring, extracted functions to class/module, then adopted flow and adjust output format
5. Replaced original functions with new classes and methods, made sure all tests are still pass
6. Started implementation Help section and refactoring around player input control to allow player using help command

### 4. Final stage - fine tune, tweaks and QA
1. Implemented runnable bundle command and fine tune the wordings, output format, game flow and etc.
2. Renamed method/classes to be more accurate based on my understanding to the domain
3. Upgraded ruby and bundler, cleaning up and better formatting
4. Manual testing, fixed few bugs (you might know what these are, or not)

### 5. Potential improvements: mix of both product and coding point of view (in no specific order)
1. STDOUT and logging - lot of `puts` in the code, which can be extracted or replaced by something better
2. Dynamic key binding - use arrow keys to move around without press enter key
3. Random final room location and random final boss HP and damage
4. Random battles in other rooms
5. Better random room description combination
6. Better challenge generater
7. Battle style - maybe RNG on damage, different attack type/skills, or different attacking order
8. User input handling
9. Score system based on the time and/or hp left at the end of the game
10. It should display a room histroy if requested by player
11. Flexible game difficulty with different map size, challenge RNG and boss


# Requirements and examples
## We need a small textual role-playing game to entertain our team members!

### Key points:
- A brief English sentence describes the room where you enter (ex. “You are in front of an old medieval castle…”)
- You can move between the rooms using some keyboard inputs
- There should be at least 4 different rooms
- There could be some events in the rooms
- You need to fight a final enemy
- A help section for the commands is necessary

### Tech specifications:
- The game should run without errors
- An object-oriented Ruby App is required
- It must be fully tested (with automation tests)

### Extra:
- The app doesn't have to be too complicated but we like well-designed projects;
- The quality of tests is as important as the one of the app.
- Feel free to express your creativity :)

---
### An example of the outcome could be:

```
You are in room A, there are 2 doors in front of you and there is a book on a table, what do you do?
[1] Open the book
[2] Open the door on the left
[3] Open the door on the right
> 2

You entered room B, there is a challenge to solve:
10 x 5
> 50

You have solved the challenge! Now you have 2 doors in front of you, what do you do?
…continue
```
