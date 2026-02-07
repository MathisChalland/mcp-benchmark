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
  id: string;
  name: string;
  supplierId: string | null;
  categoryId: string | null;
  quantityPerUnit: string | null;
  unitPrice: number | null;
  unitsInStock: number | null;
  unitsOnOrder: number | null;
  reorderLevel: number | null;
  discontinued: number;
}

export interface Order {
  id: string;
  customerId: string | null;
  employeeId: string | null;
  orderDate: string | null; // ISO date string
  requiredDate: string | null; // ISO date string
  shippedDate: string | null; // ISO date string
  shipVia: string | null;
  freight: number | null;
  shipName: string | null;
  shipAddress: string | null;
  shipCity: string | null;
  shipRegion: string | null;
  shipPostalCode: string | null;
  shipCountry: string | null;
}

export interface Employee {
  id: string;
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
  reportsToId: string | null;
  photoPath: string | null;
}

export interface Supplier {
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
  homepage: string | null;
}

export interface OrderDetail {
  orderId: string;
  productId: string;
  unitPrice: number;
  quantity: number;
  discount: number;
}

export interface Shipper {
  id: string;
  companyName: string;
  phone: string | null;
}

export interface Category {
  id: string;
  name: string;
  description: string | null;
}

export interface Region {
  id: string;
  description: string;
}

export interface Territory {
  id: string;
  description: string;
  regionId: string;
}

export interface EmployeeTerritory {
  employeeId: string;
  territoryId: string;
}
