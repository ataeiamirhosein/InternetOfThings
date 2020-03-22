/*
 *@author Amirhosein Ataei
 *@id 10722472
 *@date March 22 2020
 */

#ifndef RADIO_COUNT_TO_LEDS_H
#define RADIO_COUNT_TO_LEDS_H

typedef nx_struct radio_count_msg {
  nx_uint16_t counter;
  nx_uint16_t id;
} radio_count_msg_t;

enum {
  AM_RADIO_COUNT_MSG = 6,
};

#endif
