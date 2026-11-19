export interface State {
    insertQuarter(): void;
    ejectQuarter(): void;
    turnCrank(): void;
    refill(): void;

    entry(): void;
    toString(): string;
}