{
  "name": "Gumball Machine — Version 1 Design",
  "description": "COMP H3032 Design Patterns · Week 9 State · the Mighty Gumball controller as a state machine (Mermaid + nomnoml), before refactoring.",
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
      "name": "Start",
      "x": 0,
      "y": 0,
      "text": "# Mighty Gumball, Inc.\n\n### Version 1 design — the gumball machine as a state machine\n\n*\"Where the Gumball Machine is Never Half Empty\"*\n\n> The engineers' brief: implement the controller (the book says Java; we use TypeScript), and keep the design **as flexible and maintainable as possible** — more behaviour is coming.\n\n<!--\nSpeaker note: this story redraws the engineers' hand-sketched diagram as Mermaid and nomnoml.\nVersion 1 implements it with if-statements; keep an eye on what will hurt when the change request arrives.\n-->\n"
    },
    {
      "name": "States-and-Actions",
      "x": 240,
      "y": 0,
      "text": "# States and actions\n\n| States | Actions (what a customer can do) |\n|---|---|\n| **No Quarter** | insert quarter |\n| **Has Quarter** | eject quarter |\n| **Gumball Sold** | turn crank |\n| **Out of Gumballs** | *(machine)* dispense gumball |\n\nEach state answers *every* action — but most answers are \"you can't do that now\".\n\n<style scoped>section { font-size: 28px; }</style>\n"
    },
    {
      "name": "nomnoml-Diagram",
      "x": 720,
      "y": 0,
      "text": "# State Chart Diagram\n\n```nomnoml\n#direction: right\n#spacing: 110\n#padding: 14\n#edgeMargin: 10\n#gutter: 10\n#arrowSize: 0.7\n#.state: visual=roundrect fill=#fdf6e3 bold\n#.decision: visual=rhomb fill=#f3efb0\n[<start>start]\n[<decision>​]\n[<state>No Quarter]\n[<state>Has Quarter]\n[<state>Gumball Sold]\n[<state>Out of Gumballs]\n[start] -> [​]\n[No Quarter] \\[gumballs \\> 0\\] <- [​]\n[​] \\[gumballs == 0\\] -> [Out of Gumballs]\n[No Quarter] inserts quarter -> [Has Quarter]\n[Has Quarter] ejects quarter -> [No Quarter]\n[Has Quarter] turns crank -> [Gumball Sold]\n[Gumball Sold] dispense -> [​]\n```\n"
    },
    {
      "name": "Transition-Table",
      "x": 960,
      "y": 0,
      "text": "# Every state × every action\n\n| State ↓ / Action → | insert quarter | eject quarter | turn crank | dispense |\n|---|---|---|---|---|\n| **No Quarter** | → Has Quarter | ✗ no quarter | ✗ no quarter | ✗ |\n| **Has Quarter** | ✗ already one | → No Quarter | → Gumball Sold | ✗ |\n| **Gumball Sold** | ✗ wait | ✗ already turned | ✗ turning twice | ◇ [gumballs > 0] → No Quarter<br>◇ [gumballs == 0] → Out of Gumballs |\n| **Out of Gumballs** | ✗ sold out | ✗ no quarter | ✗ no gumballs | ✗ |\n\nOnly the **4 green cells** change the state — they are the diagram's arrows. The other **12 cells** are still behaviour the code must handle.\n\n**◇** = a decision diamond on the state chart: the guard in [ ] picks the next state.\n\n<style scoped>\nsection { font-size: 20px; }\n/* the state-change cells (row, column) - light green */\ntbody tr:nth-child(1) td:nth-child(2),\ntbody tr:nth-child(2) td:nth-child(3),\ntbody tr:nth-child(2) td:nth-child(4),\ntbody tr:nth-child(3) td:nth-child(5) { background-color: #d8f5d0; }\n</style>\n"
    },
    {
      "name": "Version-1-Code-Shape",
      "x": 1200,
      "y": 0,
      "text": "# Version 1: states as constants, actions as if-chains\n\n```ts\nexport class GumballMachine {\n  private static readonly SOLD_OUT = 0;\n  private static readonly NO_QUARTER = 1;\n  private static readonly HAS_QUARTER = 2;\n  private static readonly SOLD = 3;\n  private state = GumballMachine.SOLD_OUT;  // constructor: if count > 0 THEN state -> NO_QUARTER\n\n  public insertQuarter(): void {\n    if (this.state === GumballMachine.HAS_QUARTER) {\n      console.log(\"You can't insert another quarter\");\n    } else if (this.state === GumballMachine.NO_QUARTER) {\n      console.log(\"You inserted a quarter\");\n      this.state = GumballMachine.HAS_QUARTER;\n    } else if (this.state === GumballMachine.SOLD_OUT) {\n      console.log(\"You can't insert a quarter, the machine is sold out\");\n    } else if (this.state === GumballMachine.SOLD) {\n      console.log(\"Please wait, we're already giving you a gumball\");\n    }\n  }\n}\n```\n\n`static readonly` = a class constant (like Java's `final static int`).\nOne method per **action**, one branch per **state** → the table, sliced by column.\nSee `src/GumballMachine.ts`.\n\n<style scoped>section { font-size: 18px; }</style>\n"
    },
    {
      "name": "Design-Questions",
      "x": 1440,
      "y": 0,
      "text": "# Before the change request arrives…\n\n- Adding a **new state** touches *every* action method.\n- Adding a **new action** means a new method with a branch for *every* state.\n- Where does the behaviour *for one state* live? Scattered across four methods.\n\n> Is this \"as flexible and maintainable as possible\"? Hold that thought for **version 2**.\n"
    }
  ]
}
