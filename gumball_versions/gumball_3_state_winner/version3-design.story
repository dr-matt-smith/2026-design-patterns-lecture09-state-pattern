{
  "name": "Gumball Machine — Version 3 Design (Winner state)",
  "description": "COMP H3032 Design Patterns · Week 9 State · the 1-in-10 winner change request, handled by adding a WinnerState class.",
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
      "text": "# Mighty Gumball, Inc.\n\n### Version 3 — the change request: a WINNER state\n\n*\"Where the Gumball Machine is Never Half Empty\"*\n\n> **10% of the time, when the crank is turned, the customer gets two gumballs instead of one.**\n\n<!--\nSpeaker note: this is the change request the version-1 design was not ready for.\nCode: gumball_3_state_winner/src/\n-->\n"
    },
    {
      "name": "Version-1-Would-Need",
      "x": 240,
      "y": 0,
      "text": "# With version 1's if-chains…\n\n- a new constant `WINNER = 4`\n- a new `else if (this.state === WINNER)` branch in **every** action method\n- `turnCrank()` decides whether you win, `dispense()` handles one *or* two gumballs\n\n> Every method changes — and every change risks breaking the states that already worked.\n"
    },
    {
      "name": "With-The-State-Pattern",
      "x": 480,
      "y": 0,
      "text": "# With the State pattern\n\n| File | Change |\n|---|---|\n| `WinnerState.ts` | **new** class |\n| `HasQuarterState.ts` | `turnCrank()` picks `SoldState` **or** `WinnerState` |\n| `GumballMachine.ts` | holds the new state, `getWinnerState()` |\n| `NoQuarterState.ts`, `SoldState.ts`, `SoldOutState.ts` | **no change** |\n\n> Only the code that *meets* the new state is touched.\n"
    },
    {
      "name": "State-Classes",
      "x": 720,
      "y": 0,
      "text": "# The State classes, plus `WinnerState`\n\n```nomnoml\n#direction: down\n#spacing: 50\n#padding: 10\n#edgeMargin: 6\n#.interface: fill=#e8f1fb italic\n#.new: fill=#ffe9a8 bold\n[<interface>«interface» State|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[«interface» State] <:-- [SoldState|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[«interface» State] <:-- [SoldOutState|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[«interface» State] <:-- [NoQuarterState|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[«interface» State] <:-- [HasQuarterState|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[«interface» State] <:-- [<new>WinnerState|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n```\n\nAdding a state = adding **one class** that implements `State`. *(The code also adds `refill()`.)*\n\n<style scoped>\nsection { font-size: 24px; }\nsvg[data-nomnoml] { max-height: 420px; }\n</style>\n"
    },
    {
      "name": "Class-Diagram",
      "x": 960,
      "y": 0,
      "text": "# The design (nomnoml)\n\n```nomnoml\n#direction: down\n#spacing: 40\n#padding: 10\n#edgeMargin: 6\n#.interface: fill=#e8f1fb italic\n#.new: fill=#ffe9a8 bold\n[GumballMachine|- state: State;- count: number|insertQuarter();ejectQuarter();turnCrank();refill(count);setState(state);releaseBall()]\n[<interface>«interface» State|insertQuarter();ejectQuarter();turnCrank();dispense();refill()]\n[GumballMachine] state o-> [«interface» State]\n[«interface» State] <:-- [NoQuarterState]\n[«interface» State] <:-- [HasQuarterState]\n[«interface» State] <:-- [SoldState]\n[«interface» State] <:-- [SoldOutState]\n[«interface» State] <:-- [<new>WinnerState]\n```\n\n<style scoped>section { font-size: 24px; } svg[data-nomnoml] { max-height: 470px; }</style>\n"
    },
    {
      "name": "State-Chart-Diagram",
      "x": 1200,
      "y": 0,
      "text": "# State Chart Diagram\n\n```nomnoml\n#direction: right\n#spacing: 110\n#padding: 14\n#edgeMargin: 10\n#gutter: 10\n#arrowSize: 0.7\n#.state: visual=roundrect fill=#fdf6e3 bold\n#.decision: visual=rhomb fill=#f3efb0\n#.new: visual=roundrect fill=#ffe9a8 bold\n[<start>start]\n[<decision>​]\n[<state>No Quarter]\n[<state>Has Quarter]\n[<state>Sold]\n[<state>Sold Out]\n[<new>Winner]\n[<decision>​​]\n[start] -> [​]\n[No Quarter] \\[gumballs \\> 0\\] <- [​]\n[​] \\[gumballs == 0\\] -> [Sold Out]\n[No Quarter] inserts quarter -> [Has Quarter]\n[Has Quarter] ejects quarter -> [No Quarter]\n[Has Quarter] turns crank -> [​​]\n[​​] \\[1 in 10\\] -> [Winner]\n[​​] \\[else\\] -> [Sold]\n[Sold] dispense -> [​]\n[Winner] dispense 2 -> [​]\n[Sold Out] refill -> [No Quarter]\n```\n\n<style scoped>section { font-size: 24px; }</style>\n"
    },
    {
      "name": "Transition-Table",
      "x": 1440,
      "y": 0,
      "text": "# Every state × every action\n\n| State ↓ / Action → | insert quarter | eject quarter | turn crank | dispense | refill |\n|---|---|---|---|---|---|\n| **No Quarter** | → Has Quarter | ✗ no quarter | ✗ no quarter | ✗ pay first | – |\n| **Has Quarter** | ✗ already one | → No Quarter | ◇ [1 in 10] → Winner<br>◇ [else] → Sold | ✗ | – |\n| **Sold** | ✗ wait | ✗ already turned | ✗ turning twice | ◇ [gumballs > 0] → No Quarter<br>◇ [gumballs == 0] → Sold Out | – |\n| **Winner** | ✗ wait | ✗ wait | ✗ turning again | *(2 gumballs)*<br>◇ [gumballs > 0] → No Quarter<br>◇ [gumballs == 0] → Sold Out | – |\n| **Sold Out** | ✗ sold out | ✗ no quarter | ✗ no gumballs | ✗ | → No Quarter |\n\nOnly the **6 green cells** change the state — they are the diagram's arrows. The other **19 cells** are still behaviour the code must handle.\n\nThe new state is **one new row** = one new class. Only one existing cell changed: Has Quarter × turn crank.\n\n**◇** = a decision diamond on the state chart: the guard in [ ] picks the next state.\n\n<style scoped>\nsection { font-size: 18px; }\n/* the state-change cells (row, column) - light green */\ntbody tr:nth-child(1) td:nth-child(2),\ntbody tr:nth-child(2) td:nth-child(3),\ntbody tr:nth-child(2) td:nth-child(4),\ntbody tr:nth-child(3) td:nth-child(5),\ntbody tr:nth-child(4) td:nth-child(5),\ntbody tr:nth-child(5) td:nth-child(6) { background-color: #d8f5d0; }\n</style>\n"
    },
    {
      "name": "Choosing-A-Winner",
      "x": 1680,
      "y": 0,
      "text": "# `HasQuarterState`: choosing a winner\n\n```ts\nexport class HasQuarterState implements State {\n  constructor(private gumballMachine: GumballMachine, private random: () => number = Math.random) {}\n\n  public turnCrank(): void {\n    console.log(\"You turned...\");\n    const winner = Math.floor(this.random() * 10); // 0 to 9\n    if (winner === 0 && this.gumballMachine.getCount() > 1) {\n      this.gumballMachine.setState(this.gumballMachine.getWinnerState());\n    } else {\n      this.gumballMachine.setState(this.gumballMachine.getSoldState());\n    }\n  }\n  // ... the other actions are unchanged\n}\n```\n\n`random` defaults to `Math.random` — the tests pass in their own, so they decide who wins.\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "The-Winner-State",
      "x": 1920,
      "y": 0,
      "text": "# `WinnerState`: two gumballs\n\n```ts\npublic dispense(): void {\n  this.gumballMachine.releaseBall();\n  if (this.gumballMachine.getCount() === 0) {\n    this.gumballMachine.setState(this.gumballMachine.getSoldOutState());\n  } else {\n    this.gumballMachine.releaseBall();\n    console.log(\"YOU'RE A WINNER! You got two gumballs for your quarter\");\n    if (this.gumballMachine.getCount() > 0) {\n      this.gumballMachine.setState(this.gumballMachine.getNoQuarterState());\n    } else {\n      console.log(\"Oops, out of gumballs!\");\n      this.gumballMachine.setState(this.gumballMachine.getSoldOutState());\n    }\n  }\n}\n```\n\nThe other actions just say *\"Please wait…\"* — like `SoldState`.\n\n<style scoped>section { font-size: 22px; }</style>\n"
    },
    {
      "name": "Design-Questions",
      "x": 2160,
      "y": 0,
      "text": "# Discussion\n\n- `WinnerState` repeats much of `SoldState` — could it reuse it? (*a shared base class?*)\n- Should the **states** decide the next state, or should the **machine**? What does each choice cost?\n- Could the state objects be **shared** between machines? (*hint: they keep no data of their own — but they do hold `gumballMachine`*)\n- Strategy and State have the **same class diagram**. What is different about their *intent*?\n"
    }
  ]
}
