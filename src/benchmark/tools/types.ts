export interface Customer {
  id: string;
  name: string;
  email: string;
  address: string;
  createdAt: Date;
}

export interface Product {
  id: string;
  name: string;
  description: string;
  price: number; // Price in Cent
  stock: number;
  createdAt: Date;
}

export interface Order {
  id: string;
  customerId: string;
  orderDate: Date;
  total: number; // Total price in Cent
  status: string;
}
