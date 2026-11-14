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
      "name": "Learning-Outcomes",
      "x": 240,
      "y": 0,
      "text": "# OO Design Patterns <br> Week 9(a) — State Machine Diagrams\n\n## Learning outcomes\n\nYou will be able to:\n\n- **Define**\n  - state\n  - state transition events\n  - UML state chart diagram\n- **Identify and understand**\n  - the different elements of state chart diagrams\n- **Create**\n  - state chart diagrams to model simple system changes\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Origins Harel 1987",
      "x": 60,
      "y": 0,
      "text": "# Origins are “statecharts” from David Harel 1987\n**Harel, D. (1987).** A Visual Formalism for Complex Systems. Science of Computer Programming, 231–274.\n\nhttps://www.weizmann.ac.il/math/harel/sites/math.harel/files/users/user56/Statecharts.pdf\n\n\n![](../diagrams/harel_statecharts_1987.webp)"
    },
    {
      "name": "Similar-Terms",
      "x": 240,
      "y": 180,
      "text": "# A note on terminology <br>many similar terms in computing\n\n- UML 2.0 the term **\"state machine diagrams\"** is now used!\n- UML 1: **\"state chart diagrams\"** and **\"state diagrams\"**\n- In general computing and engineering you may find these terms used:\n  - State Diagrams / State Chart Diagrams\n  - State Transition Networks / Diagrams (STN / STD)\n  - Finite State Machines (FSM)\n<https://en.wikipedia.org/wiki/Finite-state_machine>\n  - Finite State Automata (FSA)\n\n### All of the above relate to modelling a system as: \n- >moving between different **states** <br>depending on **events** that take place\n\n<style scoped>section { font-size: 28px; }</style>\n"
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
      "text": "# Finite or infinite? Discrete or continuous?\n\n- Important to know if what is being modelled has a\n  - **finite** (an integer number), OR\n  - **infinite** set of possible states\n- Computing usually deals with\n  - finite states\n  - transitions between states treated as **instantaneous**\n  - systems modelled as having **discrete** (not continuous) states\n    - hands of an analogue watch — *continuous*\n    - digits of a digital watch — *discrete*\n\n- Modelling a system (or parts of a system) as being in **one of a finite set of states** is part of an approach called **\"finite state machines\"**\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "Definition-FSM",
      "x": 480,
      "y": 720,
      "text": "# Finite state systems\n\nA model for systems with **finite sets of discrete states**\n\n- Features\n  - **initial state** (there can be only 1 initial state)\n  - set of possible **events**\n  - **state transition function**\n     - rules to decide the next state, given each event\n  - also may be a set of **outputs** — some states may result in system outputs\n- Some states may be **terminal states**\n  - no further states may occur\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "Definition-Transition",
      "x": 240,
      "y": 540,
      "text": "# Definition: STATE TRANSITION\n\nA **transition** describes when a system **changes from one state to another state**\n  - the new state may be the same as, or different to, the previous state …\n\n## An example: <br> State Machine for \"Traffic light number 2\"\n\n```nomnoml\n#direction: right\n#spacing: 60\n#padding: 12\n#fontSize: 11\n#edgeMargin: 4\n#arrowSize: 0.8\n#.red:   visual=roundrect fill=#f4a6a6 bold\n#.green: visual=roundrect fill=#a8dba8 bold\n\n[<red>RED] -> [<green>GREEN]\n```\n\n<style scoped>\nsection svg { width: 80%; height: auto; }\n</style>"
    },
    {
      "name": "Event-Light-Switch",
      "x": 480,
      "y": 540,
      "text": "# EVENT\n\n- Usually state transitions are **not random!**\n  - some **event** occurs to trigger the change of state\n  - state machine diagrams should have events **labelled** on each state transition\n\n## State Machine for \"Light switch 15\"\n2 states: OFF, ON\n\n1 transition (arrow): event \"Light switch pressed”\n\n\n```nomnoml\n#direction: right\n#spacing: 60\n#padding: 12\n#fontSize: 11\n#edgeMargin: 4\n#arrowSize: 0.8\n#.green: visual=roundrect fill=#a8dba8 bold\n\n[<green>OFF] - [<label>Light switch pressed]\n[<label>Light switch pressed] -> [<green>ON]\n```\n\n\n"
    },
    {
      "name": "Event-Traffic-Light",
      "x": 720,
      "y": 540,
      "text": "# EVENT\n\nIn most cases state transition arrows will be labelled with an <u>event</u>\n\n## State Machine for \"Traffic light number 2\"\n\n```nomnoml\n#direction: right\n#spacing: 60\n#padding: 12\n#fontSize: 11\n#edgeMargin: 4\n#arrowSize: 0.8\n#.red:   visual=roundrect fill=#f4a6a6 bold\n#.green: visual=roundrect fill=#a8dba8 bold\n#.amber: visual=roundrect fill=#f7d08a bold\n\n[<red>RED] - [<label>goGreen()]\n[<label>goGreen()] -> [<green>GREEN]\n```\n\n\nThe <u>event</u> in the above is the system receiving the “goGREEN()” message\n- detailed systems designs often show events as methods to be implemented"
    },
    {
      "name": "Definition-Statechart",
      "x": 480,
      "y": 900,
      "text": "# Definition: State Machine Diagram\n\n- A diagram technique to represent the **set of transitions between finite states** of the item being modelled\n\n- Features\n  - **rounded rectangles** represent states\n\n  - **directed line segments** (arrows!) represent transitions between states\n\n - small number of other special symbols\n"
    },
    {
      "name": "UML-Symbols",
      "x": 720,
      "y": 900,
      "text": "# UML statechart symbols\n\n\n ![](../images/rucoy-highlander-1037288105.gif)\n\n| Symbol | Meaning |\n|---|---|\n| ● | **initial state**<br>filled small black circle (there can be only one initial state!)|\n| ◉ | **final (terminal) state** <br>black circle outline containing a smaller filled circle <br>(‘bullseye’) |\n| ![h:50](../images/state_on.svg) | **state** <br>state name inside a rounded rectangle |\n| ![](../images/transition.svg)  | **transition** <br>solid arrow from source to target state |\n\n```mermaid\nstateDiagram-v2\n    direction LR\n    [*] --> State1\n    State1 --> [*] : event\n```\n\n<style scoped>\nsection { font-size: 24px; position: relative; }\nimg[src*=\"highlander\"] { position: absolute; top: 40px; right: 60px; width: 380px; z-index: 0; }\ntable { position: relative; z-index: 1; }\n</style>\n"
    },
    {
      "name": "more UML symbols",
      "x": 320,
      "y": 80,
      "text": "\n| Symbol | Meaning |\n|---|---|\n| ![h:60](../images/transition_labelled.svg) | **transition event** <br>event name annotating a transition arrow |\n| ![](../images/decision.svg) | **decision diamond** <br>transition to follow will be  based on guard conditions |\n| `[condition]` | **guard** <br>true/false condition |\n\n\n![](../images/grade_decision.svg)\n\n"
    },
    {
      "name": "More UML symbols",
      "x": 360,
      "y": 120,
      "text": "## State entry/exit/do behaviours (internal activities)\n\n![](../images/state_game_won.svg)\nWhen system enters state `Game Won`, then 1 will be addded to system variable `score`\n\n| Label | UML name | Meaning |\n|---|---|---|\n| `entry/` | **entry behaviour** | Runs once when the state is entered, <br>whichever transition led in. |\n| `do/` | **do activity**  | Runs while the object is in the state. <br>It can be long-running or repeating, and it is interrupted if a transition leaves the state. |\n| `exit/` | **exit behaviour** | Runs once when the state is left, <br>whichever transition led out. |\n\n\n\n\n"
    },
    {
      "name": "Traffic-Lights",
      "x": 960,
      "y": 900,
      "text": "# Example state machine diagram for TRAFFIC LIGHTS\n\n\n\n```nomnoml\n#direction: right\n#spacing: 60\n#padding: 12\n#fontSize: 11\n#edgeMargin: 4\n#arrowSize: 0.8\n#.red:   visual=roundrect fill=#f4a6a6 bold\n#.green: visual=roundrect fill=#a8dba8 bold\n#.amber: visual=roundrect fill=#f7d08a bold\n\n[<start>start] -> [<red>RED]\n[<red>RED] - [<label>goGreen()]\n[<label>goGreen()] -> [<green>GREEN]\n[<green>GREEN] - [<label>goAmber()]\n[<label>goAmber()] -> [<amber>AMBER]\n[<red>RED] <- [<label>goRed()]\n[<label>goRed()] - [<amber>AMBER]\n```\n\n"
    },
    {
      "name": "Movie-Statechart",
      "x": 240,
      "y": 1080,
      "text": "# State Machine Diagram for a simple movie player <br>(with start / pause / continue buttons)\n\n\n\n```nomnoml\n#direction: right\n#spacing: 90\n#padding: 12\n#fontSize: 11\n#edgeMargin: 4\n#arrowSize: 0.8\n\n[<start>start] loaded() -> [<state>INITIALISED]\n[<state>INITIALISED] startButton() -> [<state>RUNNING]\n[<state>RUNNING] - [<label>pauseButton()]\n[<label>pauseButton()] -> [<state>PAUSED]\n[<state>RUNNING] <- [<label>resumeButton()]\n[<label>resumeButton()] - [<state>PAUSED]\n```\n\n<style scoped>section { font-size: 26px; }</style>\n\n"
    },
    {
      "name": "Space Invaders Ship Control",
      "x": 280,
      "y": 40,
      "text": "# State Machine Diagram: Player Ship \n\n![bg fit](../diagrams/ship_state_chart.svg)\n\n<style scoped>\nsection {\n  display: flex !important;\n  flex-direction: column !important;\n  justify-content: flex-start !important;  /* push content to the top */\n  vertical-align: top !important;          /* in case the theme centres a different way */\n  text-align: right;\n}\nh1 { font-size: 1.2em; margin-top: 0; }\n</style>\n\nX-position being changed..."
    },
    {
      "name": "Student-Exercise",
      "x": 480,
      "y": 1080,
      "text": "# Student exercise\n\nDraw state transition diagrams for:\n\n- a **bank account**\n- a **front door**\n"
    },
    {
      "name": "Summary-Points",
      "x": 240,
      "y": 1260,
      "text": "# Summary\n\n- Many aspects of computing can be modelled as **changes between finite states**\n- The computing theory of **Finite State Machines (FSM)** formalises the theory of finite state systems\n- **State chart diagrams** are a simple diagram modelling tool for interactive system design\n  - **States**\n    - initial state\n    - may have 1 or more terminal states\n  - **Events**\n    - may be system, user or scripted\n  - **Transitions** between states\n\n<style scoped>section { font-size: 26px; }</style>\n"
    },
    {
      "name": "Online-Links",
      "x": 720,
      "y": 1440,
      "text": "# Further reading\n\n- statecharts.dev — *How to use statecharts*\n  <https://statecharts.github.io/how-to-use-statecharts.html>\n\n- Stately — onlne aniomated statecharts\n  <https://editor.stately.ai/?source=landing-page>\n\n- Nancy Drew RPG (gist)\n  <https://gist.github.com/thure/dcffc30117b9a9800084>\n\n- Unity game engine examnples (if you’re interested ...)\n  - Kodeco (Ray Wenderlich) — *State Pattern using Unity*\n    <https://www.kodeco.com/6034380-state-pattern-using-unity>\n\n  - Matt Smith — Unity cookbook state pattern\n  <https://github.com/dr-matt-smith/unity-cookbook-2018-ch14-02-state-pattern>\n\n\n"
    },
    {
      "name": "Ref-FOLDOC",
      "x": 480,
      "y": 1440,
      "text": "# FOLDOC (2004)\n\n- **Free On-Line Dictionary Of Computing**\n- Definitions of computing terms\n- Last visited March 2004\n- <https://foldoc.org/>\n\n![w:420](../images/foldoc.png)\n"
    }
  ]
}
