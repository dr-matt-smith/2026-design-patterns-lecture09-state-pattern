import { assertEquals } from "@std/assert";
import { GumballMachine } from "../src/GumballMachine.ts";

// The machine prints with console.log (like the book's System.out.println), so to check what it
// printed, a test swaps console.log for a function that collects the lines, runs the action, then puts it back.
function printed(action: () => void): string[] {
  const lines: string[] = [];
  const original = console.log;
  console.log = (...args: unknown[]) => lines.push(args.join(" "));
  try {
    action();
  } finally {
    console.log = original;
  }
  return lines;
}

Deno.test("a machine with gumballs starts waiting for a quarter", () => {
  const machine = new GumballMachine(2);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("an empty machine starts sold out", () => {
  const machine = new GumballMachine(0);
  assertEquals(machine.getState(), machine.getSoldOutState());
});

Deno.test("insert a quarter, then eject it", () => {
  const machine = new GumballMachine(2);
  assertEquals(printed(() => machine.insertQuarter()), ["You inserted a quarter"]);
  assertEquals(machine.getState(), machine.getHasQuarterState());
  assertEquals(printed(() => machine.ejectQuarter()), ["Quarter returned"]);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("buying a gumball", () => {
  const machine = new GumballMachine(2);
  printed(() => machine.insertQuarter());
  assertEquals(printed(() => machine.turnCrank()), ["You turned...", "A gumball comes rolling out the slot..."]);
  assertEquals(machine.getCount(), 1);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("buying the last gumball sells the machine out", () => {
  const machine = new GumballMachine(1);
  printed(() => machine.insertQuarter());
  assertEquals(printed(() => machine.turnCrank()), [
    "You turned...",
    "A gumball comes rolling out the slot...",
    "Oops, out of gumballs!",
  ]);
  assertEquals(machine.getState(), machine.getSoldOutState());
  assertEquals(printed(() => machine.insertQuarter()), ["You can't insert a quarter, the machine is sold out"]);
});

Deno.test("refilling a sold out machine gets it going again", () => {
  const machine = new GumballMachine(0);
  printed(() => machine.refill(5));
  assertEquals(machine.getCount(), 5);
  assertEquals(machine.getState(), machine.getNoQuarterState());
});

Deno.test("turning the crank with no quarter does nothing", () => {
  const machine = new GumballMachine(2);
  assertEquals(printed(() => machine.turnCrank()), ["You turned, but there's no quarter", "You need to pay first"]);
  assertEquals(machine.getCount(), 2);
});
