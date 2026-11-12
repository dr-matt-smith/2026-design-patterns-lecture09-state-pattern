{
  "name": "State Chart diagrams",
  "description": "COMP Design Patterns · Week 9 State · States, events, transitions, FSMs and UML state chart diagrams (converted from state_charts.pptx).",
  "navigation": {
    "show": true,
    "style": "arrows-name",
    "position": "top-right",
    "showNumber": true
  },
  "sequenceArrows": {
    "show": true,
    "style": "dashed",
    "color": "#ffcc00",
    "alpha": 0.55
  },
  "nodes": [
    {
      "name": "Title",
      "x": 0,
      "y": 0,
      "text": "# State Chart diagrams\n\n### COMP Design Patterns · Week 9 — State\n\n<!--\nConverted from state_charts.pptx (slide 1).\n-->\n"
    },
    {
      "name": "Learning-Outcomes",
      "x": 240,
      "y": 0,
      "text": "# Learning outcomes\n\nYou will be able to:\n\n- **Define**\n  - State\n  - Event & state transition\n  - UML state chart diagram\n- **Identify and understand**\n  - the different elements of state chart diagrams\n- **Create**\n  - state chart diagrams to model games and movie clips\n- **Argue with examples**\n  - why state chart diagrams are useful for modelling all/parts of interactive computer systems, such as games\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Terminology",
      "x": 0,
      "y": 180,
      "text": "# A note on terminology\n"
    },
    {
      "name": "Similar-Terms",
      "x": 240,
      "y": 180,
      "text": "# Several similar terms in computing\n\n- In UML the terms **\"state chart diagrams\"** and **\"state diagrams\"** are synonymous\n- In general computing and engineering you may find these terms used:\n  - State Diagrams\n  - State Transition Networks / Diagrams (STN / STD)\n  - Finite State Machines (FSM)\n  - Finite State Automata (FSA)\n\n### All of the above relate to modelling a system as: \n- >moving between different **states** <br>depending on **events** that take place\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "State",
      "x": 0,
      "y": 360,
      "text": "# State\n"
    },
    {
      "name": "Definition-State",
      "x": 240,
      "y": 360,
      "text": "# Definition: STATE\n\nThe **current configuration** of the item in question\n(i.e. its current set of attribute / property values)\n\n- usually **temporary** — changes with time\n- usually **volatile** — lost / reset if the system is switched off\n\n**Examples of simple states**\n\n- Traffic light is **GREEN**\n- Game is in **PAUSE MODE**\n- Calculator is **DISPLAYING RESULT OF CALCULATION**\n- Light switch in **OFF POSITION**\n- Database user's **PASSWORD ACCEPTED**\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Finite-and-Discrete",
      "x": 480,
      "y": 360,
      "text": "# Finite or infinite? Discrete or continuous?\n\n- Important to know if what is being modelled has a\n  - **finite** (an integer number), OR\n  - **infinite** set of possible states\n- Computing usually deals with\n  - finite states\n  - transitions between states treated as **instantaneous**\n  - systems modelled as having **discrete** (not continuous) states\n    - hands of an analogue watch — *continuous*\n    - digits of a digital watch — *discrete*\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "Events-and-Transitions",
      "x": 0,
      "y": 540,
      "text": "# Events & State Transitions\n"
    },
    {
      "name": "Definition-Transition",
      "x": 240,
      "y": 540,
      "text": "# Definition: STATE TRANSITION\n\n- Description / modelling of a system **changing from one state to another state**\n  - the new state may be the same as, or different to, the previous state …\n\n**Traffic light number 2**\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    RED --> GREEN\n```\n"
    },
    {
      "name": "Event-Light-Switch",
      "x": 480,
      "y": 540,
      "text": "# EVENT\n\n- Usually state transitions are **not random!**\n  - some **event** occurs to trigger the change of state\n  - statechart diagrams should have events **labelled** on each state transition\n\n**Statechart for \"Light switch 15\"**\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    OFF --> ON : Light switch pressed\n```\n\n<!-- The label on the arrow is the EVENT. -->\n"
    },
    {
      "name": "Event-Traffic-Light",
      "x": 720,
      "y": 540,
      "text": "# EVENT\n\n- Usually state transitions are **not random!**\n  - some **event** occurs to trigger the change of state\n  - statechart diagrams should have events **labelled** on each state transition\n\n**Statechart for \"Traffic light number 2\"**\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    RED --> GREEN : \"goGREEN\" message received\n```\n"
    },
    {
      "name": "Finite-State-Machine",
      "x": 0,
      "y": 720,
      "text": "# Finite State Machine\n"
    },
    {
      "name": "FSM-Family",
      "x": 240,
      "y": 720,
      "text": "# Finite state machine\n\n- State chart diagrams belong to a family of computing science theory and techniques that model systems in terms of **changing states**\n- Modelling a system (or parts of a system) as being in **one of a finite set of states** is part of an approach called **\"finite state machines\"**\n"
    },
    {
      "name": "Definition-FSM",
      "x": 480,
      "y": 720,
      "text": "# Definition: FINITE STATE MACHINE\n\nA model for systems with **finite sets of discrete states**\n\n- Features\n  - **initial state** (there can be only 1 initial state)\n  - set of possible **events**\n  - **state transition function** — method to decide the next state given events\n  - also may be a set of **outputs** — some states may result in system outputs\n- Some states may be **terminal states**\n  - no further states may occur\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "State-Chart-UML",
      "x": 0,
      "y": 900,
      "text": "# State Chart\n\n### (UML diagram)\n"
    },
    {
      "name": "Definition-Statechart-Alhir",
      "x": 240,
      "y": 900,
      "text": "# Definition: STATECHART DIAGRAM\n\n**Alhir (1998, p.187)**\n\n> \"State chart diagrams describe the life cycle of an object. <br>These diagrams contain states and transitions.\"\n\n> \"These diagrams describe the behaviour of a class in response to external stimuli.\"\n"
    },
    {
      "name": "Definition-Statechart",
      "x": 480,
      "y": 900,
      "text": "# Definition: STATECHART DIAGRAM\n\n- A diagram technique to represent the **set of transitions between finite states** of the item being modelled\n- Features\n  - **rounded rectangles** represent states\n  - **directed line segments** (arrows!) represent transitions between states\n"
    },
    {
      "name": "UML-Symbols",
      "x": 720,
      "y": 900,
      "text": "# UML statechart symbols\n\n| Symbol | Meaning |\n|---|---|\n| ● | **initial state** — filled small black circle |\n| ◉ | **final (terminal) state** — black circle outline containing a smaller filled circle |\n| ▢ `ON` | **state** — state name inside a rounded rectangle |\n| ⟶ `event` | **transition** — event name by a solid arrow from source to target state |\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    [*] --> ON : event\n    ON --> [*] : event\n```\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "Traffic-Lights",
      "x": 960,
      "y": 900,
      "text": "# Example statechart diagram for TRAFFIC LIGHTS\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    [*] --> RED\n    RED --> GREEN : goGreen()\n    GREEN --> AMBER : goAmber()\n    AMBER --> RED : goRed()\n```\n\n\n"
    },
    {
      "name": "Movie-Example",
      "x": 0,
      "y": 1080,
      "text": "# Simple movie example\n"
    },
    {
      "name": "Movie-Statechart",
      "x": 240,
      "y": 1080,
      "text": "# State chart for a simple movie player\n\n(with start / pause / continue buttons)\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    [*] --> INITIALISED : E1\n    INITIALISED --> RUNNING : E2\n    RUNNING --> PAUSED : E3\n    PAUSED --> RUNNING : E4\n```\n\nThe input / event triggering each transition can be labelled:\n\n- **E1** = loaded\n- **E2** = Start button clicked\n- **E3** = Pause button clicked\n- **E4** = Continue button clicked\n\n<!-- The original slide said \"simple Flash movie\". -->\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Student-Exercise",
      "x": 480,
      "y": 1080,
      "text": "# Student exercise\n\nDraw state transition diagrams for:\n\n- a **bank account**\n- a **front door**\n- the **player ship** in Space Invaders\n"
    },
    {
      "name": "Summary",
      "x": 0,
      "y": 1260,
      "text": "# Summary / Conclusions\n"
    },
    {
      "name": "Summary-Points",
      "x": 240,
      "y": 1260,
      "text": "# Summary\n\n- Many aspects of computing can be modelled as **changes between finite states**\n- The computing theory of **Finite State Machines (FSM)** formalises the theory of finite state systems\n- **State chart diagrams** are a simple diagram modelling tool for interactive system design\n  - **States**\n    - initial state\n    - may have 1 or more terminal states\n  - **Events**\n    - may be system, user or scripted\n  - **Transitions** between states\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "References",
      "x": 0,
      "y": 1440,
      "text": "# References / online references\n"
    },
    {
      "name": "Ref-Alhir",
      "x": 240,
      "y": 1440,
      "text": "# Alhir (1998)\n\n**Sinan Si Alhir**\n\n- *UML in a Nutshell*\n- O'Reilly\n- ISBN: 1-56592-448-7\n"
    },
    {
      "name": "Ref-FOLDOC",
      "x": 480,
      "y": 1440,
      "text": "# FOLDOC (2004)\n\n- **Free On-Line Dictionary Of Computing**\n- Definitions of computing terms\n- Last visited March 2004\n- <https://foldoc.org/>\n\n![w:420](images/foldoc.png)\n"
    },
    {
      "name": "Online-Links",
      "x": 720,
      "y": 1440,
      "text": "# Further reading\n\n- statecharts.dev — *How to use statecharts*\n  <https://statecharts.github.io/how-to-use-statecharts.html>\n- SCION — executable statecharts\n  <http://scion.scxml.io/>\n- Nancy Drew RPG (gist)\n  <https://gist.github.com/thure/dcffc30117b9a9800084>\n- Ray Wenderlich — *State Pattern using Unity*\n  <https://www.raywenderlich.com/6034380-state-pattern-using-unity>\n- Matt Smith — Unity cookbook state pattern\n  <https://github.com/dr-matt-smith/unity-cookbook-2018-ch14-02-state-pattern>\n\n<!-- Not in the PPTX: taken from links.txt in this folder. -->\n\n<style scoped>section { font-size: 24px; }</style>\n"
    }
  ]
}
