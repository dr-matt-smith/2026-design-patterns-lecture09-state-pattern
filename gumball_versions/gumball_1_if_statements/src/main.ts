import { GumballMachine } from "./GumballMachine.ts";

// main.ts - a simple text menu for the gumball machine, run in the terminal
//
//   deno run src/main.ts

const machine = new GumballMachine(5);

function showMenu(): void {
  console.log("\n1 - insert a quarter");
  console.log("2 - eject the quarter");
  console.log("3 - turn the crank");
  console.log("q - quit");
}

function isValidChoice(choice: string): boolean {
  return choice === "1" || choice === "2" || choice === "3" || choice === "q";
}

function showStatus(): void {
  console.log(`---------------------------`);
  console.log(`State: ${machine.getStateName()}`);
  console.log(`Gumballs: ${machine.getCount()}`);
}

while (true) {
  showStatus();
  showMenu();
  const choice = (prompt(">") ?? "q").trim().toLowerCase();

  if (!isValidChoice(choice)) {
    console.log(`Invalid choice "${choice}" - please enter 1, 2, 3 or q`);
    continue;
  }

  if (choice === "q") {
    break;
  }

  if (choice === "1") {
    machine.insertQuarter();
  } else if (choice === "2") {
    machine.ejectQuarter();
  } else if (choice === "3") {
    machine.turnCrank();
  }
}

console.log("Goodbye!");
