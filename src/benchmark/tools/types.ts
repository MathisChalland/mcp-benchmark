export interface Customer {
  id: string;
  companyName: string;
  contactName: string | null;
  contactTitle: string | null;
  address: string | null;
  city: string | null;
  region: string | null;
  postalCode: string | null;
  country: string | null;
  phone: string | null;
  fax: string | null;
}

export interface Product {
  id: number;
  name: string;
  supplierId: number | null;
  categoryId: number | null;
  quantityPerUnit: string | null;
  unitPrice: number | null;
  unitsInStock: number | null;
  unitsOnOrder: number | null;
  reorderLevel: number | null;
  discontinued: number;
}

export interface Order {
  id: number;
  customerId: string | null;
  employeeId: number | null;
  orderDate: string | null; // ISO date string
  requiredDate: string | null; // ISO date string
  shippedDate: string | null; // ISO date string
  shipVia: number | null;
  freight: number | null;
  shipName: string | null;
  shipAddress: string | null;
  shipCity: string | null;
  shipRegion: string | null;
  shipPostalCode: string | null;
  shipCountry: string | null;
}

export interface Category {
  id: number;
  name: string;
  description: string | null;
}

export interface Employee {
  id: number;
  lastName: string;
  firstName: string;
  title: string | null;
  titleOfCourtesy: string | null;
  birthDate: string | null; // ISO date string
  hireDate: string | null; // ISO date string
  address: string | null;
  city: string | null;
  region: string | null;
  postalCode: string | null;
  country: string | null;
  homePhone: string | null;
  extension: string | null;
  notes: string | null;
  reportsToId: number | null;
  photoPath: string | null;
}

export interface Supplier {
  id: number;
  companyName: string;
  contactName: string | null;
  contactTitle: string | null;
  address: string | null;
  city: string | null;
  region: string | null;
  postalCode: string | null;
  country: string | null;
  phone: string | null;
  fax: string | null;
  homepage: string | null;
}

export interface OrderDetail {
  orderId: number;
  productId: number;
  unitPrice: number;
  quantity: number;
  discount: number;
}

export interface Shipper {
  id: number;
  companyName: string;
  phone: string | null;
}

export interface Region {
  id: number;
  description: string;
}

export interface Territory {
  id: string;
  description: string;
  regionId: number;
}

export interface EmployeeTerritory {
  employeeId: number;
  territoryId: string;
}
