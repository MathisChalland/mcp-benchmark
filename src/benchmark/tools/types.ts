export interface Customer {
  id: string;
  name: string;
  email: string;
  address: string;
  createdAt: string; // ISO date string
}

export interface Product {
  id: string;
  name: string;
  description: string;
  price: number; // Price in Cent
  stock: number;
  createdAt: string; // ISO date string
}

export interface Order {
  id: string;
  customerId: string;
  orderDate: string; // ISO date string
  total: number; // Total price in Cent
  status: string;
}
