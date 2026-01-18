import "dotenv/config";
import { db } from "@/server/db";
import { faker } from "@faker-js/faker";

async function main() {
  await db.orderItem.deleteMany();
  await db.order.deleteMany();
  await db.product.deleteMany();
  await db.customer.deleteMany();

  console.log("Creating 20 customers...");
  const customers = [];
  for (let i = 0; i < 20; i++) {
    const customer = await db.customer.create({
      data: {
        email: faker.internet.email(),
        name: faker.person.fullName(),
        address: faker.location.streetAddress({ useFullAddress: true }),
      },
    });
    customers.push(customer);
  }

  console.log("Creating 50 products...");
  const products = [];
  for (let i = 0; i < 50; i++) {
    const product = await db.product.create({
      data: {
        name: faker.commerce.productName(),
        description: faker.commerce.productDescription(),
        price: parseFloat(
          faker.commerce.price({ min: 10 * 100, max: 500 * 100 }),
        ),
        stock: faker.number.int({ min: 0, max: 200 }),
      },
    });
    products.push(product);
  }

  console.log("Creating orders over the past year...");
  const statuses = [
    "pending",
    "processing",
    "shipped",
    "delivered",
    "cancelled",
  ];
  const now = new Date();
  const oneYearAgo = new Date();
  oneYearAgo.setFullYear(now.getFullYear() - 1);

  for (let i = 0; i < 250; i++) {
    const customer = faker.helpers.arrayElement(customers);
    const orderDate = faker.date.between({ from: oneYearAgo, to: now });
    const status = faker.helpers.arrayElement(statuses);

    const numItems = faker.number.int({ min: 1, max: 5 });
    let orderTotal = 0;
    const orderItems = [];

    for (let j = 0; j < numItems; j++) {
      const product = faker.helpers.arrayElement(products);
      const quantity = faker.number.int({ min: 1, max: 5 });
      const price = product.price;
      orderTotal += price * quantity;

      orderItems.push({
        productId: product.id,
        quantity,
        price,
      });
    }

    await db.order.create({
      data: {
        customerId: customer.id,
        orderDate,
        status,
        total: orderTotal,
        orderItems: {
          create: orderItems,
        },
      },
    });

    if ((i + 1) % 100 === 0) {
      console.log(`${i + 1} orders created...`);
    }
  }

  console.log("Seeding completed!");
  console.log(`- ${customers.length} customers`);
  console.log(`- ${products.length} products`);
  console.log("- 250 orders");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await db.$disconnect();
  });
