<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */
listen = 9000
// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME') );

/** Database username */
define( 'DB_USER', getenv('DB_USER') );

/** Database password */
define( 'DB_PWD', getenv('DB_PWD') );

/** Database hostname */
define( 'DB_HOST', getenv('DB_HOST') );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'L&g{1[upT hpah]-LsT~<YrrC090eaV^fym@i=XF%g-$[}{IP;NX+~*W^(jKJ$Um');
define('SECURE_AUTH_KEY',  ']CmeS#_T$:b._=42t034EO{G~1I[KI_c2WF=-wy+Qc@W<>(qXjaN*+blmy|oS)O+');
define('LOGGED_IN_KEY',    'BZx}1[+(6+71f|RGn2{ $31*8jiFKEA&>O+(S,b2DnJ4TxUkh0tpBArYehhWr@vi');
define('NONCE_KEY',        'KCJQd6z@wV@[L@>1:C5L|N[>?B=2)9C^T*_vbgUkbgH<)sHK9A*ovn`G^3<D^3)$');
define('AUTH_SALT',        's7Vyx=e10>x#U w!OF,ga}`;(ktsEEZ&8A2k%<T=hq|%`~;e_+_*k`$C.aT$9YBD');
define('SECURE_AUTH_SALT', '7 U2PR&)~Q1N)k;<)]BFH[}3CsSz|HQ8Q,bK`o-VN6qKFAF;$$-V)i?`,^_s1{b]');
define('LOGGED_IN_SALT',   '9)-jut+hwo2L+%U^b&Q,m6yDx(-#5=oO+5Lej+rEh~+1-h[C2hb=,6h!|Fbo:5xR');
define('NONCE_SALT',       'oy9Hp((u|$5.Gso!pVU+Axy<2;W0KgF=45f*Op}H`/,=W$m$@dq(irpmSmWf:79o');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
