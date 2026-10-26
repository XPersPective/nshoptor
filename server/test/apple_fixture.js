import { X509Certificate } from 'node:crypto';
import js from 'jsrsasign';
import jwt from 'jsonwebtoken';

// Real cryptographic fixture: test-only CA, intermediate with Apple's required
// extension, and leaf with Apple's transaction-signing extension. No mock
// verifier and no production trust changes. Private keys are ephemeral.
const keys = Array.from({ length: 3 }, () => js.KEYUTIL.generateKeypair('EC', 'secp256r1'));
function certificate(index, issuer, extension) {
  return js.KJUR.asn1.x509.X509Util.newCertPEM({
    serial: { int: index + 1 }, sigalg: 'SHA256withECDSA',
    issuer: { str: `/CN=Apple fixture ${issuer}` }, subject: { str: `/CN=Apple fixture ${index}` },
    notbefore: '240101000000Z', notafter: '350101000000Z',
    sbjpubkey: keys[index].pubKeyObj, cakey: keys[issuer].prvKeyObj,
    ext: [{ extname: 'basicConstraints', cA: index !== 2 },
      ...(extension ? [{ extname: extension, extn: '0500' }] : [])],
  });
}
const certificates = [certificate(0, 0), certificate(1, 0, '1.2.840.113635.100.6.2.1'),
  certificate(2, 1, '1.2.840.113635.100.6.11.1')];
const x5c = certificates.map(cert => new X509Certificate(cert).raw.toString('base64')).reverse();
const privateKey = js.KEYUTIL.getPEM(keys[2].prvKeyObj, 'PKCS8PRV');
const leafPublicKey = new X509Certificate(certificates[2]).publicKey;
const now = Date.UTC(2026, 9, 26, 12);
const payload = {
  bundleId: 'com.crazypenguin.nshoptor', environment: 'Production',
  originalTransactionId: '1000000000001', transactionId: '1000000000002',
  productId: 'nshoptor_pro_v2', type: 'Auto-Renewable Subscription',
  purchaseDate: now - 86400000, signedDate: now, expiresDate: now + 86400000,
};
const env = () => ({ APPLE_BUNDLE_ID: payload.bundleId, APPLE_APP_ID: '123456789',
  APPLE_KEY_ID: 'ABCDEFGHIJ', APPLE_ISSUER_ID: '12345678-1234-1234-1234-123456789abc',
  APPLE_PRIVATE_KEY: privateKey });
const signed = (fields = {}, options = {}) => jwt.sign({ ...payload, ...fields }, privateKey,
  { algorithm: 'ES256', header: { x5c }, ...options });
const testTrust = { roots: [new X509Certificate(certificates[0]).raw], onlineChecks: false };
const response = (token, { status = 1, originalTransactionId = payload.originalTransactionId, ...fields } = {}) => ({
  bundleId: payload.bundleId, appAppleId: 123456789, environment: 'Production',
  data: [{ lastTransactions: [{ status, originalTransactionId, signedTransactionInfo: token }] }], ...fields,
});

export { now, payload, env, signed, response, testTrust, x5c, privateKey, leafPublicKey };

