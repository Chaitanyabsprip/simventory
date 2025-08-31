import Alpine from "alpinejs";
import type { TaskStore } from "./task-store";
import type { Task } from "./tasks";
export const productionPrefix: Record<string, string> = {
  "building-supplies-store": "bs",
  "hardware-store": "hs",
  "farmers-market": "fm",
  "furniture-store": "fs",
  "gardening-supplies": "gs",
  "donut-shop": "ds",
  "fashion-store": "fa",
  "fast-food-restaurant": "ff",
  "home-appliances": "ha",
  "eco-shop": "eco",
  "car-parts": "cc",
  "silk-store": "lc",
  "tropical-products-store": "cos",
  "fish-marketplace": "ff",
  "santas-workshop": "hd",
  factory: "",
  "oil-plant": "cc",
  "green-factory": "eco",
  "mulberry-grove": "lc",
  "coconut-farm": "coconuts",
  fishery: "fish",
};

export interface CreateTaskStore {
  requirements: Record<string, number>;
  name: string;
  complete: () => boolean;
  addItem: (itemId: string) => void;
  removeItem: (itemId: string) => void;
  hasRequirements: () => boolean;
}

export default {
  requirements: {},
  name: "",
  complete() {
    if (!this.name.trim()) {
      alert("Please enter a task name.");
      return false;
    }
    if (!this.hasRequirements()) {
      alert("Please add at least one requirement.");
      return false;
    }
    const taskStore = Alpine.store("tasks") as TaskStore;
    const task = {
      name: this.name,
      requirements: this.requirements,
      status: "todo" as const,
    } as Task;
    taskStore.addTask(task);
    this.name = "";
    this.requirements = {};
    return true;
  },
  addItem(itemId: string) {
    this.requirements[itemId] = (this.requirements[itemId] || 0) + 1;
  },
  removeItem(itemId: string) {
    this.requirements[itemId] = Math.max(
      (this.requirements[itemId] || 1) - 1,
      0,
    );
    if (this.requirements[itemId] === 0) {
      delete this.requirements[itemId];
    }
  },
  hasRequirements() {
    return Object.values(this.requirements).some((qty) => qty > 0);
  },
} as CreateTaskStore;
