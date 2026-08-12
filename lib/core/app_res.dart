import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppRes {
  AppRes._();

  // ─────────────────────────────────────────────
  // COLORS
  // ─────────────────────────────────────────────

  static const Color primaryBlack = Colors.black;
  static const Color primaryWhite = Colors.white;
  static const Color white = Colors.white;

  static const Color tileColor = Color(0xFF2A2A2A);

  static const Color accentOrange = Color(0xFFFF5722);
  static const Color accentOrangeLight = Color(0xFFFF7E4A);

  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentAmber = Color(0xFFFFB300);
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color seedColor = Color(0xFF003366);

  // ─────────────────────────────────────────────
  // BACKGROUNDS
  // ─────────────────────────────────────────────

  static const BoxDecoration backgroundGradient = BoxDecoration(
    color: Colors.black,
  );

  // ─────────────────────────────────────────────
  // BUTTON
  // ─────────────────────────────────────────────

  static const BoxDecoration buttonGradient = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    gradient: LinearGradient(
      colors: [accentOrangeLight, accentOrange],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );

  // ─────────────────────────────────────────────
  // TEXT GRADIENT
  // ─────────────────────────────────────────────

  static const LinearGradient textGradient = LinearGradient(
    colors: [accentOrangeLight, accentOrange],
  );

  // ─────────────────────────────────────────────
  // TEXT STYLES
  // ─────────────────────────────────────────────

  static TextStyle get appBarTitle => GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: primaryWhite,
  );

  static TextStyle get bodyText => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryBlack,
  );

  static TextStyle get bodyTextBold => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: primaryBlack,
  );

  static TextStyle get headingText => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: primaryBlack,
  );

  static TextStyle get tabLabel => GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle get tabDate =>
      GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w800);

  static TextStyle get dropdownText => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryWhite,
  );

  static TextStyle get announcementText => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryBlack,
  );

  static TextStyle get effectiveDate => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryBlack,
  );

  static TextStyle get todayLabel => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: primaryBlack,
  );

  // ─────────────────────────────────────────────
  // DARK UI TEXT
  // ─────────────────────────────────────────────

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static TextStyle get monoSemibold => GoogleFonts.robotoMono(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: white,
  );

  static TextStyle get roboto => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: white,
  );
}
