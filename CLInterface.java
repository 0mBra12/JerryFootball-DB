package Project;

import java.sql.*;
import java.util.*;
import java.math.*;

public class part4 {
	// JDBC driver name and database URL
	private static final String JDBC_DRIVER = "";
	static final String DB_URL = "";

	// Database credentials
	private static final String USER = "";
	private static final String PASS = "";

	Random rand = new Random();
	static int player_id = 0;
	static int Order_ID = 0;

	public part4() {
		try {
			// register jdbc
			Class.forName(JDBC_DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/************************** GET CONNECTION **************************/
	private Connection Getconnection() {
		Connection conn = null;
		try {
			// Open a connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("database connected!");

		} catch (Exception e) { // handle errors from class.forname
			e.printStackTrace();
		}
		return conn;
	}

	/*************************** Option 1 operation **********************/
	public void Option1() {
		Connection conn = null;
		Statement stmt = null;
		int address_id;
		String player_name;
		int orders;
		String sql;
		//Order_ID = rand.nextInt(100) + 1;
		player_id = rand.nextInt(100) + 1;

		// get connected to the player relation
		conn = Getconnection();
		try {
			stmt = conn.createStatement();
			//sql = "select order_id from Orders";
			sql = "select player_id from player";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				orders = rs.getInt(1);
				if (orders == player_id)
					player_id = rand.nextInt(600) + 1;
			}
			// instruct the users to input details
			System.out.println("The Player ID allocates for you is: " + player_id);
			System.out.println("Please input the player's name: ");
			//System.out.println("tip -> valid address id: integer 1 to 600 ");
			player_name = getInput(); // get the player's name;
			// keep the input in the range of constraints
			/*while (address_id < 1 || address_id > 600) {
				System.out.println("invaild adress id (1 to 600), try again");
				address_id = Integer.parseInt(getInput());
			}
			*/
			// construct the sql query
			sql = "insert into player (player_id, player_name) values (" + player_id + ", '" + player_name + "')";
			// execute the query
			stmt.executeUpdate(sql);

		} catch (SQLException se) { // handle the errors from jdbc
			se.printStackTrace();

		} finally {
			// finally block used to close resource
			try {
				if (stmt != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			} // do nothing
			try {
				if (conn != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			}
			// end finally try
		}// end try
		System.out
				.println("   Congratulations!     ");
		System.out
				.println("More details need to be done, please choose option 2 !");
	}

	/************************* Option 2 Operation ************************/
	public void Option2() {
		Connection conn = null;
		Statement stmt = null;
		int order_id;
		int product_id;
		int supplier_id;
		String sql;
		conn = Getconnection();
		try {

			stmt = conn.createStatement();
			// order id
			order_id = Order_ID;
			System.out.println("The order ID is: " + order_id);
			// product id
			System.out.println("please input the product ID: ");
			System.out.println("tip -> valid product id: integer 1 to 500 ");
			product_id = Integer.parseInt(getInput());
			while (product_id < 1 || product_id > 500) {
				System.out.println("invalid product id(1 to 500), try agian ");
				product_id = Integer.parseInt(getInput());
			}
			// supplier id
			System.out.println("please input the supplier ID: ");
			System.out.println("tip -> valid supplier id: integer 1 to 100 ");
			supplier_id = Integer.parseInt(getInput());
			while (supplier_id < 1 || supplier_id > 100) {
				System.out.println("invalid supplier id(1 to 100), try agian ");
				supplier_id = Integer.parseInt(getInput());
			}

			sql = "insert into Order_detail (order_id, product_id, supplier_id) values ((select order_id from orders where order_id = "
					+ order_id
					+ "), (select product_id from Product where product_id = "
					+ product_id
					+ "), (select supplier_id from Supplier where supplier_id = "
					+ supplier_id + "))";
			// System.out.println("sql is: " + sql);

			stmt.executeUpdate(sql);

		} catch (SQLException se) { // handle the errors from jdbc
			se.printStackTrace();

		} finally {
			// finally block used to close resource
			try {
				if (stmt != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			} // do nothing
			try {
				if (conn != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			}
			// end finally try
		}// end try
		System.out
				.println("(   Congratulations!     ");

	}

	/************************* Option 3 Operation ************************/
	public void Option3() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int supplier_id;
		String product_num;
		String product_name;
		BigDecimal product_price;

		String sql;
		conn = Getconnection();
		try {

			stmt = conn.createStatement();
			System.out.println("please input supplier ID: ");
			// get supplier id
			System.out.println("tip -> valid supplier id: integer 1 to 100 ");
			supplier_id = Integer.parseInt(getInput());
			while (supplier_id < 1 || supplier_id > 100) {
				System.out.println("invalid supplier id(1 to 100), try agian ");
				supplier_id = Integer.parseInt(getInput());
			}
			// get the num
			sql = "select count(product_id) from Product  group by supplier_id having supplier_id ="
					+ supplier_id + " ";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				product_num = rs.getString(1);
				System.out
						.println("The total num of products provided by this supplier is: "
								+ product_num);
			}
			sql = "select product_name, product_price from Product  where supplier_id ="
					+ supplier_id;
			rs = stmt.executeQuery(sql);
			System.out.println("+-------------------+---------------------+");
			System.out.println("|   product_name    |     product_price   |");
			System.out.println("+-------------------+---------------------+");
			while (rs.next()) {
				product_name = rs.getString(1);
				product_price = rs.getBigDecimal(2);
				System.out.print("|  " + product_name);
				System.out.println("                " + product_price + "");
				System.out
						.println("+-------------------+---------------------+");
			}

		} catch (SQLException se) { // handle the errors from jdbc
			se.printStackTrace();

		} finally {
			// finally block used to close resource
			try {
				if (stmt != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			} // do nothing
			try {
				if (conn != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			}
			// end finally try
		}// end try
		System.out
				.println("   Congratulations!     ");

	}

	/************************* Option 4 Operation ************************/
	public void Option4() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int customer_id;
		int payment_id;
		long card;
		String sql;
		conn = Getconnection();
		try {

			stmt = conn.createStatement();
			System.out.println("please input customer ID: ");
			System.out.println("tip -> valid customer id: integer 1 to 500 ");
			customer_id = Integer.parseInt(getInput());
			while (customer_id < 1 || customer_id > 100) {
				System.out
						.println("invalid customer id (1 to 500), try agian ");
				customer_id = Integer.parseInt(getInput());
			}
			// show all card of this customer
			sql = "select payment_id, card from Payment where customer_id = "
					+ customer_id;
			rs = stmt.executeQuery(sql);
			System.out.println("+-------------------+---------------------+");
			System.out.println("|   payment_id      |         card        |");
			System.out.println("+-------------------+---------------------+");
			while (rs.next()) {
				payment_id = rs.getInt(1);
				card = rs.getLong(2);
				System.out.print("|  " + payment_id);
				System.out.println("                    " + card + "");
				System.out
						.println("+-------------------+---------------------+");
			}
			// choose one of payment to change
			System.out.println("please choose from the existed payments: ");
			payment_id = Integer.parseInt(getInput());
			System.out.println("please input new card Information: ");
			card = Long.parseLong(getInput());
			sql = " update Payment set card = " + card
					+ " where   customer_id =  " + customer_id
					+ " AND payment_id =  " + payment_id;
			stmt.executeUpdate(sql);
			// printout the updated information
			System.out.println("After updating");
			sql = "select payment_id, card from Payment where customer_id = "
					+ customer_id;
			rs = stmt.executeQuery(sql);
			System.out.println("+-------------------+---------------------+");
			System.out.println("|   payment_id      |         card        |");
			System.out.println("+-------------------+---------------------+");
			while (rs.next()) {
				payment_id = rs.getInt(1);
				card = rs.getLong(2);
				System.out.print("|  " + payment_id);
				System.out.println("                    " + card + "");
				System.out
						.println("+-------------------+---------------------+");
			}

		} catch (SQLException se) { // handle the errors from jdbc
			se.printStackTrace();

		} finally {
			// finally block used to close resource
			try {
				if (stmt != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			} // do nothing
			try {
				if (conn != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			}
			// end finally try
		}// end try
		System.out
				.println("(   Congratulations!     ");

	}
	
	/*************************** Option 5 operation **********************/
	public void Option5() {
		Connection conn = null;
		Statement stmt = null;
		int address_id;
		int orders;
		String sql;
		Order_ID = rand.nextInt(600) + 1;

		// get connected to the orders relations
		conn = Getconnection();
		try {
			stmt = conn.createStatement();
			sql = "select order_id from Orders";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				orders = rs.getInt(1);
				if (orders == Order_ID)
					Order_ID = rand.nextInt(600) + 1;
			}
			// instruct the customers to input details
			System.out
					.println("The Order ID allocates for you is: " + Order_ID);
			System.out.println("Please input your address id: ");
			System.out.println("tip -> valid address id: integer 1 to 600 ");
			address_id = Integer.parseInt(getInput()); // get the input adress
														// id
			// keep the input in the range of constraints
			while (address_id < 1 || address_id > 600) {
				System.out.println("invaild adress id (1 to 600), try again");
				address_id = Integer.parseInt(getInput());
			}

			// construct the sql query
			sql = "insert into Orders (order_id, address_id) values ("
					+ Order_ID + ", "
					+ "(select address_id from address where address_id = "
					+ address_id + "))";
			// execute the query
			stmt.executeUpdate(sql);

		} catch (SQLException se) { // handle the errors from jdbc
			se.printStackTrace();

		} finally {
			// finally block used to close resource
			try {
				if (stmt != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			} // do nothing
			try {
				if (conn != null)
					conn.close();
				stmt.close();
			} catch (SQLException se) {
			}
			// end finally try
		}// end try
		System.out
				.println("   Congratulations!     ");
		System.out
				.println("More details need to be done, please choose option 2 !");
	}

	/***************************** Get Query *****************************/
	private String getInput() { // get the input query
		String input;
		Scanner scan = new Scanner(System.in);
		input = scan.nextLine();
		return input;
	}

	/****************************** Select Interface ********************/
	private void OptionsTable() {

		System.out.println();
		System.out.println("Choose from those five options");
		System.out
				.println("+---------+---------------------------------------------+");
		System.out
				.println("|  --- 1) |  Insert a new player                        |");
		System.out
				.println("|  --- 2) |  Insert a new address record                |");
		System.out
				.println("|  --- 3) |  Show information of one game               |");
		System.out
				.println("|  --- 4) |  Show number of games each university wins  |");
		System.out
				.println("|  --- 5) |  Update a coach's university                |");
		System.out
				.println("|  --- 6) |  Quit                                       |");
		System.out
				.println("+---------+---------------------------------------------+");

	}

	/****************************** Main Method ***************************/
	public static void main(String[] args) {
		part4 test = new part4();
		boolean flag;
		int option;
		// indicates five alternative options
		test.OptionsTable();

		Scanner scan = new Scanner(System.in);
		option = Integer.parseInt(scan.nextLine());
		while (true) {

			if (option == 1)
				test.Option1();

			else if (option == 2)
				test.Option2();

			else if (option == 3)
				test.Option3();

			else if (option == 4)
				test.Option4();

			else if (option == 5)
				test.Option5();
			
			else if (option == 6) {
				System.out.println("bye!");
				break;
			}

			test.OptionsTable();
			option = Integer.parseInt(scan.nextLine());

		}
	}
}
